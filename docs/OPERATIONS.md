# Operations

## Runbook
- Kickoff: `Database.executeBatch(new SlackUserPhotoBatch(), 200)`
- Success: updated count matches target cohort; failures = 0
- Fields used for audit: Slack_Avatar_Hash__c, Slack_Photo_Last_Synced__c

## Common issues
- 429 from Slack → auto backoff; rerun batch
- Image too large → 512→192 fallback then resize; rerun if still failing
- No SF user for email → listed as miss; fix data then rerun

## Rollback
- Not destructive. Old photos can be restored via user profile photo history if available.
