# sf-slack-userpics-to-salesforce

Synchronise Slack profile photos to Salesforce Users. Uses Custom Metadata for the Slack bot token and Batch Apex for scale.

## How it works
- Look up Slack user by email (`users.lookupByEmail`)
- Compare avatar hash to `User.Slack_Avatar_Hash__c`
- Download `image_512` (fallback `image_192`), set photo via ConnectApi
- Stamp `Slack_Photo_Last_Synced__c` and new hash

## Prereqs
- Custom Metadata: **SlackApi_Token__mdt** record **Org_Default** with **Slack_Bearer_Token__c**
- Integration user: API-only, least privilege. Connected App: *Admin-approved users only*
- User fields present: `Slack_Avatar_Hash__c` (Text), `Slack_Photo_Last_Synced__c` (DateTime)

## Run it (Anonymous Apex)
```apex
// Small run (50 users), chunk 50
Database.executeBatch(new SlackUserPhotoBatch(50), 50);

// Full run with platform default scope, chunk 200
Database.executeBatch(new SlackUserPhotoBatch(), 200);

// Queueable wrapper (respects TEST_SUPPRESS_EXECUTE in tests)
System.enqueueJob(new SlackPhotoSyncQueueable(200, 200));
