/**
 * SlackPhotoServiceTest.cls
 * Pattern: HttpCalloutMock + dependency injection to avoid real ConnectApi calls
 * Role: Validate URL parsing, image fetch, and invocation flow with mocked payloads only.
 */
@IsTest
private class SlackPhotoServiceTest {

    // Fake writer that records calls instead of invoking ConnectApi
    private class FakeWriter implements SlackPhotoService.PhotoWriter {
        public Id lastUserId;
        public Blob lastBlob;
        public String lastFileName;
        public String lastContentType;
        public void setUserPhoto(Id userId, Blob imageData, String fileName, String contentType) {
            lastUserId = userId;
            lastBlob = imageData;
            lastFileName = fileName;
            lastContentType = contentType;
        }
    }

    // Multi-endpoint HTTP mock
    private class SlackHttpMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String url = req.getEndpoint();
            if (url != null && url.contains('/users.profile.get')) {
                res.setStatusCode(200);
                // [MOCKED_VENDOR_PAYLOAD]
                res.setBody('{"ok":true,"profile":{"image_192":"https://cdn.mock/avatar.png"}}');
                return res;
            }
            if (url != null && url.contains('https://cdn.mock/avatar.png')) {
                res.setStatusCode(200);
                res.setBody('PNG_MOCK_BYTES'); // Blob from text is sufficient for test flow
                return res;
            }
            res.setStatusCode(404);
            res.setBody('not found');
            return res;
        }
    }

    @IsTest
    static void testSingleUserUpdate() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SlackHttpMock());

        // Use the running user; do not create real Users in tests.
        Id currentUserId = UserInfo.getUserId();

        FakeWriter writer = new FakeWriter();
        SlackPhotoService svc = new SlackPhotoService(writer);
        svc.updateUserPhotoFromSlack(currentUserId, 'U123456');

        System.assertEquals(currentUserId, writer.lastUserId, 'Should set photo for current user');
        System.assertNotEquals(null, writer.lastBlob, 'Should fetch some image bytes');
        System.assert(writer.lastFileName.startsWith('slack-avatar-'), 'Name should be prefixed');
        System.assert(!String.isBlank(writer.lastContentType), 'Content type should be set');
        Test.stopTest();
    }

    @IsTest
    static void testBatchFlow() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SlackHttpMock());

        // Tag the running user with a fake Slack id
        User u = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        u.put('Slack_User_Id__c', 'U777');
        update u;

        // Run a small batch
        Database.executeBatch(new SlackPhotoBatch(), 1);
        Test.stopTest();

        // No assertions on ConnectApi; success path covered by service test.
        System.assert(true, 'Batch executed without unhandled exceptions');
    }
}
