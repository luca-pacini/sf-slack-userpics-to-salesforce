# Security

This document states the security posture for the public, redacted case study. No secrets, internal identifiers, or business logic are included.

## Threat model (brief)

* **Actor**: Salesforce integration user invoking Apex callouts; Slack application exposing profile images via Web API.
* **Assets**: user avatars only (low‑risk personal data already visible in Slack).
* **Concerns**: leaked credentials, excess privileges, breaching external rate limits.

## Data classification

* Avatars are **low risk**. No sensitive categories are processed. No customer records are touched.

## Authentication and authorisation

* **Outbound auth**: access to Slack is performed via a Salesforce **Named Credential** `NC_[SERVICE]_JWT`. Secrets are **not** stored in code or Custom Metadata.
* **Connected App**: access is restricted by an **admin‑approved Connected App**; only the integration user is permitted.
* **Integration user**: a dedicated **API‑only** user with a minimal permission set (callouts and ConnectApi only) runs the job.
* **Least privilege**: the Slack app has read profile scope only. No writes to Slack.

## Secrets handling and rotation

* Secrets live in admin‑managed configuration (Named Credential). They are never committed to Git.
* **Rotation cadence**: rotate credentials per organisational policy; ensure logs confirm successful runs after rotation.
* **Audit**: peer‑reviewed changes with evidence (screenshots blurred) are attached to change records.

## Operational safeguards

* Honour external **rate limits** with batching and back‑off.
* Capture per‑user failures and favour **targeted reruns**.
* Monitor logs after scheduled runs; investigate anomalies immediately.

## Excluded from this repository

* Real hostnames, org IDs, tokens, certificates, mapping tables, or schedules.
* Any internal schema beyond generic API names used for scoping.

## Placeholders

Use only the approved placeholders in docs and examples:
`[REDACTED]`, `[MOCKED]`, `[OBFUSCATED]`, `[DUMMY_CREDENTIAL]`, `ORG_XXXXX`, `https://api.example.local`, `NC_[SERVICE]_JWT`.

## .env.template (documentation only)

```dotenv
# Documentation template only – do not store real secrets
SLACK_BASE_URL=https://api.example.local
SLACK_NAMED_CREDENTIAL=NC_[SERVICE]_JWT
GITHUB_URL=https://github.com/<your-username>/<repo-name>
```

## IP notice

**Case study. Redacted. No redistribution.**
