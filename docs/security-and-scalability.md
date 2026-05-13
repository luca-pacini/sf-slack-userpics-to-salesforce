# Security and Scalability

## Security Model

The security model is based on a simple rule: the public repository must explain the pattern without exposing the private implementation.

The private implementation should keep Slack authentication, Salesforce identifiers, matching logic and operational logs outside public source control.

## Access Model

Access should be limited to the users and automation context required to run the sync.

Recommended controls:

- Dedicated Permission Set for administrators who can configure or run the process.
- Least-privilege access for any integration or automation user.
- No broad administrative access where targeted access is sufficient.
- No public exposure of Salesforce User identifiers, Slack user identifiers or real email mappings.

## Permission Sets

Permission Sets should be used to assign operational access deliberately.

The public repository does not include real Permission Set assignments, user names or internal access groups.

## Field Level Security (FLS) and Create, Read, Update, Delete (CRUD)

Field Level Security (FLS) and Create, Read, Update, Delete (CRUD) enforcement are required where user-facing or admin-facing access is exposed.

For system-run Apex, review the execution context carefully and avoid using elevated access as a shortcut. Any user-facing controller or Lightning Web Component (LWC) added later must enforce Field Level Security (FLS) and Create, Read, Update, Delete (CRUD) before returning data.

## Data Protection

The public repository must not contain:

- Slack tokens.
- Slack workspace identifiers.
- Slack user identifiers.
- Salesforce org identifiers.
- Salesforce User record identifiers.
- Real usernames.
- Real email addresses.
- Exact matching rules.
- Internal URLs.
- Sensitive logs.
- Production deployment commands.

## Integration Security

Slack API access must be handled through a controlled authentication boundary.

Expected controls:

- Named Credential for external authentication.
- No hard-coded bearer tokens.
- No secrets in Custom Metadata Types.
- No secrets in debug logs.
- No credentials committed to GitHub history.
- Token rotation handled by administrators outside source control.

## Named Credentials

Named Credentials are the preferred Salesforce boundary for external callout authentication.

The public repository should use placeholder names only, such as `NC_[SERVICE]_JWT` or `NC_SLACK_REDACTED`.

Live Named Credential setup details are intentionally excluded.

## Logging and Monitoring

Logs must be useful without being dangerous.

Safe logs may include:

- Job status.
- Count of processed records.
- Count of skipped records.
- Generic error categories.
- Retry-needed indicators.

Logs must not include:

- Tokens.
- Raw Slack responses.
- Real email addresses.
- Slack user IDs.
- Salesforce User IDs.
- Profile image URLs where they expose sensitive identifiers.

## Auditability

Auditability should come from:

- Source control history.
- Scheduled job records.
- Apex test evidence.
- Sanitised operational logs.
- Redaction review before public publishing.

## Scalability Model

The design uses controlled Salesforce processing rather than a single large synchronous transaction.

Scalability controls:

- Batch Apex for chunked user processing.
- Scheduled Apex for predictable operation.
- Service-layer separation for maintainability.
- Mocked callouts for reliable tests.
- Configurable batch size where appropriate.

## Governor Limit Considerations

The implementation must account for:

- Callout limits per transaction.
- DML limits.
- Heap size when handling image data.
- CPU time.
- Retry behaviour when Slack responds with rate-limit errors.
- Avoiding unnecessary processing for users without eligible mappings.

## Asynchronous Design

Batch Apex is appropriate where many users may need processing.

Queueable Apex may be appropriate if the private implementation separates callout and update work further. If Queueable Apex is not present in the repository, do not claim it as implemented.

## Extension Points

Future extension points:

- Admin-facing status dashboard.
- Manual reprocess action for selected users.
- Failure queue for skipped records.
- Rate-limit reporting.
- More granular test scenarios.
- Additional source systems, only if business-approved.

## Risks and Mitigations

| Risk | Mitigation |
| --- | --- |
| Slack token exposure | Use Named Credentials and never commit secrets |
| User data exposure | Use mocked data and redact identifiers |
| API rate limits | Use batch sizing and retry-aware design |
| Salesforce governor limits | Use Batch Apex and service-layer separation |
| Incorrect user matching | Keep matching controlled, reviewed and excluded from public documentation |
| Misleading portfolio claims | Mark missing evidence as [NEEDS DETAIL] |
