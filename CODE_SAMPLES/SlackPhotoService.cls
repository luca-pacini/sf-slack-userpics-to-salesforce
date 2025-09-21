// Portfolio sample (REDACTED). Do not use in production.
// Endpoints, IDs and logic paths are obfuscated. See REDACTION.md.

/**
 * SlackPhotoService.cls
 * Pattern: Service + Dependency Injection for photo writing
 * Role: Fetch a user's Slack avatar and set it as the Salesforce profile photo.
 * Sensitive parts are replaced with placeholders and mocked in tests.
 */
public with sharing class SlackPhotoService {

    public interface PhotoWriter {
        void setUserPhoto(Id userId, Blob imageData, String fileName, String contentType);
    }

    public class ConnectApiPhotoWriter implements PhotoWriter {
        public void setUserPhoto(Id userId, Blob imageData, String fileName, String contentType) {
            // Uses supported ConnectApi to set the profile photo
            ConnectApi.BinaryInput input = new ConnectApi.BinaryInput(imageData, contentType, fileName);
            ConnectApi.UserProfiles.setPhoto(null, userId, input);
        }
    }

    private PhotoWriter photoWriter;

    public SlackPhotoService() {
        this.photoWriter = new ConnectApiPhotoWriter();
    }
    public SlackPhotoService(PhotoWriter writer) {
        this.photoWriter = writer;
    }

    /**
     * Entry point: update a single user's photo from Slack.
     * @param userId Salesforce User Id
     * @param slackUserId Slack user identifier (e.g. U123…)
     */
    public void updateUserPhotoFromSlack(Id userId, String slackUserId) {
        if (userId == null || String.isBlank(slackUserId)) {
            throw new AuraHandledException('Invalid input');
        }

        String imageUrl = fetchSlackImageUrl(slackUserId);
        if (String.isBlank(imageUrl)) {
            throw new AuraHandledException('No image URL returned from Slack for user ' + slackUserId);
        }

        Blob imageData = fetchImageBytes(imageUrl);
        // Basic content-type detection. In a governed environment prefer header-driven content type.
        String contentType = (imageUrl.toLowerCase().endsWith('.png')) ? 'image/png' : 'image/jpeg';
        String fileName = 'slack-avatar-' + slackUserId + ((contentType == 'image/png') ? '.png' : '.jpg');

        photoWriter.setUserPhoto(userId, imageData, fileName, contentType);
    }

    // Calls Slack API to obtain the profile image URL. Named Credential handles auth.
    private String fetchSlackImageUrl(String slackUserId) {
        HttpRequest req = new HttpRequest();
        // Named Credential placeholder; admin config supplies base URL and auth.
        req.setEndpoint('callout:NC_[SERVICE]_JWT/users.profile.get?user=' + EncodingUtil.urlEncode(slackUserId, 'UTF-8'));
        req.setMethod('GET');

        // Optional headers if required by your NC setup.
        // req.setHeader('Accept', 'application/json');

        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() == 429) {
            // Backoff hint; caller can retry at batch level.
            throw new CalloutException('Rate limited by Slack');
        }
        if (res.getStatusCode() >= 300) {
            throw new CalloutException('Slack profile request failed: ' + res.getStatus() + ' ' + res.getBody());
        }

        // [MOCKED_VENDOR_PAYLOAD] Example shape: {"ok":true,"profile":{"image_192":"https://.../avatar.png"}}
        Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        if (payload == null || payload.get('profile') == null) return null;

        Map<String, Object> prof = (Map<String, Object>) payload.get('profile');
        // Prefer the higher-res variant if present.
        List<String> keys = new List<String>{'image_512','image_192','image_72'};
        for (String k : keys) {
            if (prof.containsKey(k) && prof.get(k) != null) return (String) prof.get(k);
        }
        return null;
    }

    // Fetch the image bytes from the given URL.
    private Blob fetchImageBytes(String imageUrl) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(imageUrl);
        req.setMethod('GET');

        // [REDACTED_AUTH_FLOW]
        // If your Slack workspace requires auth for avatar URLs,
        // configure an Outbound Network Connection and set an Authorization header via Named Credential policy.

        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() >= 300) {
            throw new CalloutException('Image fetch failed: ' + res.getStatus());
        }
        return res.getBodyAsBlob();
    }
}
