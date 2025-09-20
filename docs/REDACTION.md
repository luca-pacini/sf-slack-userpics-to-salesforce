# Redaction and Placeholder Policy

Redactions protect confidentiality while keeping the repository evaluable. All examples use mocked or obfuscated data. Replace any sensitive value with the placeholders below.

| Placeholder | Represents | Rationale | Safe example value |
| --- | --- | --- | --- |
| [REDACTED] | Any sensitive string removed | Prevents disclosure of internal details | [REDACTED] |
| [MOCKED] | Fabricated data used in tests or docs | Makes behaviour demonstrable without real data | [MOCKED] |
| [OBFUSCATED] | Irreversibly masked identifier | Avoids re-identification from partial IDs | 9f2a****e1c |
| [DUMMY_CREDENTIAL] | Non-functional token/key | Ensures no live secret appears in code or history | dummy-token-123 |
| ORG_XXXXX | Internal org identifier | Avoids exposing tenant information | ORG_12345 |
| https://api.example.local | External API base URL | Prevents leaking real endpoints | https://api.example.local |
| NC_[SERVICE]_JWT | Named Credential label in Salesforce | Hides actual system names while showing intent | NC_[SERVICE]_JWT |

**Never commit**: real hostnames, usernames, org IDs, OAuth tokens, certificates, mapping tables, or schedules. Use the placeholders above and keep production values in admin-managed configuration only.
