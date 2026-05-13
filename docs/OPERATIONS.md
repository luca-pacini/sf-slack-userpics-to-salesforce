# Operations

## Operating Model

The synchronisation should run as a controlled Salesforce scheduled job, with Batch Apex used to process users in safe chunks.

This public version does not include production schedules, org identifiers, real user IDs, Slack workspace IDs or live deployment commands.

## Run Boundary

Example-only execution pattern:

```apex
Database.executeBatch(new SlackUserPhotoBatch(), 100);
```

Use a batch size that respects:

- Salesforce callout limits.
- Salesforce Data Manipulation Language (DML) limits.
- Slack API limits.
- Image payload size.
- Expected user volume.

Do not treat the example as a production recommendation without validating it in a sandbox.

## Failure Modes

| Failure | Expected handling |
| --- | --- |
| Slack rate limit | Back off and retry through a controlled rerun path |
| Missing Slack mapping | Skip safely and report as a non-secret operational issue |
| Missing Slack photo | Skip without failing the full batch |
| Invalid credential | Stop processing and rotate/update the Named Credential outside code |
| Salesforce update failure | Capture safe error category and support targeted rerun |

## Support Review

Administrators should review:

- Scheduled job status.
- Processed count.
- Skipped count.
- Failure categories.
- Any users requiring manual correction.

Logs must not expose tokens, real usernames, real email addresses, Salesforce User IDs, Slack user IDs, raw payloads or internal URLs.

## Manual Recovery

Manual recovery should use a controlled approach:

1. Confirm the failure category.
2. Correct configuration or user mapping outside public source control.
3. Rerun only the affected scope where possible.
4. Validate the result in Salesforce.
5. Keep any evidence sanitised before sharing publicly.
