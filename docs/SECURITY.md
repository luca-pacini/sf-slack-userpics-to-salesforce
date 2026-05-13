# Security

## Public Repository Position

This repository is a redacted portfolio artefact. It must not contain live Slack tokens, Salesforce credentials, org identifiers, usernames, email addresses, internal URLs or exact matching rules.

## Credential Boundary

Slack authentication must be handled through Salesforce Named Credentials or an equivalent administrator-managed secure configuration boundary.

Do not store Slack bearer tokens in Apex, Custom Metadata Types, Custom Settings, source-controlled files or debug logs.

Use placeholders only in public documentation, for example:

- `NC_SLACK_REDACTED`
- `[DUMMY_CREDENTIAL]`
- `https://api.example.local`

## Required Controls

- No hard-coded secrets.
- No live credentials in GitHub history.
- No real Slack workspace identifiers.
- No real Slack user identifiers.
- No real Salesforce User identifiers.
- No real email addresses.
- No raw Slack API responses in logs.
- No profile image URLs if they expose private identifiers.
- Mocked callouts in tests.
- Least-privilege Permission Sets for operational access.

## Logging Rules

Allowed in logs:

- Job started.
- Job completed.
- Processed count.
- Skipped count.
- Generic error category.

Not allowed in logs:

- Tokens.
- Secrets.
- Raw payloads.
- Real user IDs.
- Real email addresses.
- Slack user IDs.
- Internal URLs.

## Publishing Rule

Before publishing, review the repository manually and mark any unsafe file as `[DO NOT PUBLISH]` until corrected.