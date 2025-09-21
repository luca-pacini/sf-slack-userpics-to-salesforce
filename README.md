Project Purpose

Synchronise Salesforce user profile photos from Slack to keep identities consistent for internal users.

Reason for Starting

Reduce manual administration, remove stale images, and move ownership in house to improve accuracy and trust in internal identity.

Technologies Used

Salesforce, Slack, Gearset

Solution overview and business-driven choices

This integration reads each mapped userâ€™s avatar from Slack and applies it to the corresponding Salesforce user via supported platform APIs. It runs on demand for a single user or as a scheduled batch. Design is native-first to minimise operational surface and align with governance.

Native first: Apex service and batch with ConnectApi; Named Credential boundary for outbound calls.

Clear ownership: Slack is the source of truth for avatars; Salesforce presents the mastered image.

Scale with control: batching and retries respect external limits and keep runs predictable.

Change governance: Gearset promotion with peer review and evidence enables traceability and rollback.

Architecture diagram
flowchart TD
  User --> Salesforce
  Salesforce -->|Event| Queue
  Queue --> External_System

Outcomes (metrics)

Representative portfolio metrics; not client data.

Users updated: 200

Sync success rate: 99 percent

Average run time for 200 users: 8 seconds

Evidence pack (portfolio-safe)

See docs/EVIDENCE.md for artefacts and redaction rules:

BEFORE and AFTER screenshots (faces blurred, names obfuscated).

A 10â€“20 second GIF of a single-user sync using mocked data.

Screenshot of green Apex tests on mocked callouts (class names only; no code).

Security and compliance summary

Secret boundary: Named Credential NC_[SERVICE]_JWT managed by admins.

Admin-approved Connected App; access restricted by permission set.

API-only integration user; credentials rotated per policy. No secrets or endpoints in code or history.

Further detail and a documentation-only .env.template: docs/SECURITY.md.

Operability quickstart (mocked demo and tests)

Mocked demo: configure a dummy Named Credential to https://api.example.local and exercise the service with mocked responses.

Run tests: Setup â†’ Apex Test Execution â†’ run SlackPhotoServiceTest (all external calls mocked).

Runbook summary (see docs/OPERATIONS.md):

Recommended batch size: 50 to 200 users.

Failure modes: 429 responses, invalid token, no Slack mapping, image fetch errors.

Recovery: back off and retry; rotate credential in admin console; correct mappings; target reruns for failed users only.

Scope (API names only)
Category	API name(s)
Object(s) touched	User
Fields referenced	User.Slack_User_Id__c, User.Id
Apex classes	SlackPhotoService, SlackPhotoBatch, SlackPhotoServiceTest
Required metadata	NamedCredential.NC_[SERVICE]_JWT, permission set for API-only integration user, Gearset pipeline configuration (evidence only)
Limitations and trade-offs

External limits govern throughput; schedule large updates off peak.

Avatar URLs may require authorised fetch; use a Named Credential or an approved proxy.

Users may change photos manually unless governed by policy.

Demo

Portfolio demo GIF (blur icons and any names): docs/evidence/SYNC_DEMO.gif (~15 seconds). No org IDs or real endpoints.

IP notice, licence, links

IP notice: Case study. Redacted. No redistribution.

Redaction policy and placeholders: docs/REDACTION.md.

Licence: Apache-2.0 (illustrative and partially redacted).

GitHub: https://github.com/luca-pacini/sf-slack-userpics-to-salesforce
