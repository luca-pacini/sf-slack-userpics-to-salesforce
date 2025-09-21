# Redaction and Placeholder Policy

Redactions protect confidentiality whilst keeping the repository evaluable. Use mocked or obfuscated data only. Replace any sensitive value with the placeholders below.

| Placeholder                                            | Represents                            | Rationale                                         | Safe example value                                     |
| ------------------------------------------------------ | ------------------------------------- | ------------------------------------------------- | ------------------------------------------------------ |
| \[REDACTED]                                            | Sensitive text removed                | Prevents disclosure of internal details           | \[REDACTED]                                            |
| \[MOCKED]                                              | Fabricated data used in tests or docs | Demonstrates behaviour without real data          | \[MOCKED]                                              |
| \[OBFUSCATED]                                          | Irreversibly masked identifier        | Avoids re‑identification from partial IDs         | 9f2a\*\*\*\*e1c                                        |
| \[DUMMY\_CREDENTIAL]                                   | Non‑functional token or key           | Ensures no live secret appears in code or history | dummy-token-123                                        |
| ORG\_XXXXX                                             | Internal org identifier               | Avoids exposing tenant information                | ORG\_12345                                             |
| [https://api.example.local](https://api.example.local) | External API base URL                 | Prevents leaking real endpoints                   | [https://api.example.local](https://api.example.local) |
| NC\_\[SERVICE]\_JWT                                    | Named Credential label in Salesforce  | Hides actual system names whilst showing intent   | NC\_\[SERVICE]\_JWT                                    |

**Never commit**: real hostnames, usernames, org IDs, OAuth tokens, certificates, mapping tables, schedules, or environment details. Keep production values in admin‑managed configuration only.

**IP notice**: Case study. Redacted. No redistribution.