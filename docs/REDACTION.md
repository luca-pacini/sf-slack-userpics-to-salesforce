# Redaction Notice

This repository is a redacted Salesforce portfolio artefact. It is designed for public review without exposing private implementation details.

## Publishing Boundary

The repository may explain:

- The business problem.
- The Salesforce architecture pattern.
- The secure integration boundary.
- The scalability approach.
- The trade-offs and future improvements.

The repository must not expose:

- Credentials.
- Tokens.
- Secrets.
- Salesforce org IDs.
- Slack workspace IDs.
- Slack user IDs.
- Real Salesforce User IDs.
- Internal URLs.
- Real customer data.
- Exact field mappings.
- Production deployment scripts.
- Proprietary matching rules.
- Real usernames.
- Real email addresses.
- Sensitive logs.
- Package licence keys.
- Private Slack channels.
- Private Salesforce, Slack or third-party configuration.
- Live Named Credential details.

## Approved Placeholders

| Placeholder | Meaning |
| --- | --- |
| `[REDACTED]` | Sensitive text removed |
| `[MOCKED DATA]` | Fabricated data used for tests or examples |
| `[ABSTRACTED LOGIC]` | Real logic exists privately but is not safe to publish |
| `[DUMMY_CREDENTIAL]` | Non-functional credential placeholder |
| `ORG_XXXXX` | Placeholder for org or tenant reference |
| `SLACK_USER_XXXXX` | Placeholder for Slack user reference |
| `MOCK_USER_001` | Placeholder for Salesforce user reference |
| `https://api.example.local` | Non-live example endpoint |
| `NC_SLACK_REDACTED` | Placeholder Named Credential |

## Evidence Rules

Screenshots, diagrams and demos must use mocked or heavily obfuscated data.

Do not include:

- Faces unless permission exists and the image is not sensitive.
- Names.
- Emails.
- Record IDs.
- Ticket numbers.
- Hostnames.
- Internal Slack channels.
- Production timestamps.

## Human Publishing Gate

Do not publish this repository until the human publishing gate has been completed independently, away from the generated output.

The repository is only publishable if every answer is YES.

If any answer is NO, the relevant file must be revised or marked `[DO NOT PUBLISH]`.

Manual checklist:

- Is anything sensitive exposed, including org IDs, usernames, emails, URLs, credentials, object mappings, business rules, logs, tokens or internal system details?
- Can every Architecture Decision Record (ADR) be explained out loud without notes?
- Is every metric real, estimated honestly or clearly marked as observed impact?
- Can every security claim be defended in interview?
- Is it clear why each technology was used?
- Is it clear what was deliberately redacted and why?
- Does the repository show Salesforce Technical Design Architect (TDA) thinking rather than just implementation?
- Would this survive review by a Salesforce architect?
- Does this sound like the actual project, not a generic Artificial Intelligence (AI) rewrite?

If any answer is NO, mark the relevant section as `[NEEDS DETAIL]` or `[DO NOT PUBLISH]`.