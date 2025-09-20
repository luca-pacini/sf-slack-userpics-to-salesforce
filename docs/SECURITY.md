# Security

- Slack bot token: SlackApi_Token__mdt.Slack_Bearer_Token__c (Org_Default)
- Integration user: API-only profile, least privilege
- Connected App: Admin-approved users only; use allow-list if API Access Control is on
- Logs: do not print emails or token; rely on counts and user Ids

## Threat model (brief)
- **Actor**: Salesforce integration user; Slack app with profile read scope only.
- **Assets**: user avatars (low-risk personal data).
- **Concerns**: secret exposure, scope creep, rate limiting leading to failed runs.

## Data classification
Avatars are low risk. No sensitive categories processed. No customer data involved.

## Authentication and authorisation
- **Slack**: access via Named Credential `NC_[SERVICE]_JWT` with minimal read scopes for profile images.
- **Salesforce**: runs as a dedicated integration user with a permission set granting callout and ConnectApi access only (least privilege).

## Secrets handling
- No secrets in code or Git history.
- Admins manage credentials in Named Credentials.
- See `docs/REDACTION.md` for placeholders and what must never be committed.

## Excluded from this repository
- Real endpoints, org IDs, tokens, certificates.
- Internal mapping tables, schedules, and run logs.

## Operational controls
- **Rate limits**: backoff on HTTP 429 and batch size tuning.
- **Error handling**: per-user failure accounting; targeted reruns allowed.
- **Monitoring**: review execution logs after batch runs; alert when error threshold is exceeded.
- **Rollback**: revert via Gearset; optionally reapply prior photo.

## .env.template (documentation only)
```dotenv
# Documentation template only – do not store real secrets
SLACK_BASE_URL=https://api.example.local
SLACK_NAMED_CREDENTIAL=NC_[SERVICE]_JWT
GITHUB_URL=https://github.com/luca-pacini/sf-slack-userpics-to-salesforce
