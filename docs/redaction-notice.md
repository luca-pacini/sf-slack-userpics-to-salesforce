# Redaction Notice

This repository is a redacted public portfolio artefact.

It explains the business problem, architecture, security boundary and delivery approach without exposing live implementation detail.

## Redaction Markers

| Marker | Meaning |
|---|---|
| [REDACTED] | Sensitive implementation detail removed from the public repository. |
| [MOCKED DATA] | Safe example data created only for demonstration. |
| [ABSTRACTED LOGIC] | Real design pattern described without exposing copyable private logic. |
| [DUMMY CREDENTIAL] | Placeholder only. No working credential exists in this repository. |
| [SANITISED EXAMPLE] | Safe example based on the project pattern. |
| [PARTIAL IMPLEMENTATION] | Area is intentionally incomplete or simplified for portfolio safety. |
| [NEEDS DETAIL] | Claim requires stronger project evidence before publication. |
| [DO NOT PUBLISH] | Content must not be made public in its current form. |

## Excluded From Public Repository

The public repository must not include:

- Slack tokens.
- Slack workspace identifiers.
- Slack user identifiers.
- Salesforce org identifiers.
- Salesforce User record identifiers.
- Real usernames.
- Real email addresses.
- Internal URLs.
- Exact user matching rules.
- Live Named Credential details.
- Production deployment scripts.
- Sensitive logs.
- Raw Slack API responses.
- Customer data.
- Proprietary business rules.

## Public-Safe Boundary

Allowed:

- High-level architecture.
- Sanitised Apex patterns.
- Mocked callout tests.
- Redacted diagrams.
- Security and scalability rationale.
- Architecture Decision Records (ADR) that do not expose sensitive detail.

Not allowed:

- Working credentials.
- Live endpoint details.
- Real user mappings.
- Production setup instructions with internal identifiers.
- Any material that could recreate the private implementation 1:1.

## Publishing Gate

Before publishing changes, confirm:

- No credentials, tokens or secrets are present.
- No real usernames, emails or identifiers are present.
- No internal URLs are present.
- No exact matching rules are exposed.
- No sensitive logs or raw payloads are included.
- The content is useful for review but not directly deployable to production.
