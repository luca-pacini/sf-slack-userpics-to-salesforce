// Portfolio sample (REDACTED). Not for production.
// Endpoints, IDs and logic branches are obfuscated. See REDACTION.md.
// Portfolio sample (REDACTED). Do not use in production.
// Endpoints, IDs and logic paths are obfuscated. See REDACTION.md.
/**
 * SlackPhotoBatch.cls
 * Pattern: Database.Batchable with callouts and basic failure accounting
 * Role: Iterate active users with a Slack mapping and sync their profile photos.
 */
global with sharing class SlackPhotoBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

    public static final String SLACK_ID_FIELD = 'Slack_User_Id__c';

    global Integer processed = 0;
    global Integer succeeded = 0;
    global Integer failed = 0;
    global List<String> errors = new List<String>();

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String soql = 'SELECT Id,' + SLACK_ID_FIELD + ' FROM User WHERE IsActive = true AND ' + SLACK_ID_FIELD + ' != null';
        return Database.getQueryLocator(soql);
    }

    global void execute(Database.BatchableContext bc, List<User> scope) {
        SlackPhotoService svc = new SlackPhotoService();
        for (User u : scope) {
            processed++;
            try {
                String slackId = (String) u.get(SLACK_ID_FIELD);
                svc.updateUserPhotoFromSlack(u.Id, slackId);
                succeeded++;
            } catch (Exception e) {
                failed++;
                errors.add(u.Id + ': ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.INFO, 'SlackPhotoBatch summary: processed=' + processed + ', ok=' + succeeded + ', failed=' + failed);
        if (!errors.isEmpty()) {
            System.debug(LoggingLevel.WARN, 'Errors: ' + String.join(errors, '; '));
        }
    }
}


