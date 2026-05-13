# Controlled Slack-to-Salesforce User Photo Synchronisation — Redacted Portfolio Version

## TL;DR / CV Portfolio Summary

Designed a controlled Salesforce-native synchronisation pattern to improve consistency of Salesforce User profile photos using Slack as the approved image source.

The solution uses Apex, scheduled processing, mocked callouts and redacted configuration to show the architecture without exposing live Slack or Salesforce implementation details.

The public version focuses on least-privilege integration design, secure configuration boundaries, governor-limit-aware processing and operational supportability.

## Executive Summary

Salesforce user profile photos were incomplete or inconsistent, reducing recognisability in record ownership, collaboration and internal user journeys.

This project provides a controlled Slack-to-Salesforce synchronisation pattern that retrieves approved Slack profile images and applies them to corresponding Salesforce User profile photos. The architecture keeps the process Salesforce-native where practical, avoids hard-coded credentials and separates public portfolio evidence from sensitive implementation detail.

The repository is intentionally redacted. It is useful for architecture review and interview discussion, not for direct production deployment.

## Implementation Boundary

| Area | Public repository treatment |
| --- | --- |
| Salesforce Apex pattern | Real architecture pattern, with sensitive logic redacted or abstracted where required |
| Slack API access | [ABSTRACTED LOGIC] with no live endpoint, token or workspace detail |
| Credentials | [REDACTED]; represented only by safe Named Credential guidance |
| User matching | [ABSTRACTED LOGIC]; no real email, Slack user ID, Salesforce User ID or internal mapping exposed |
| Test data | [MOCKED DATA] only |
| Screenshots or evidence | [SANITISED EXAMPLE] only, if added later |
| Deployment scripts | [DO NOT PUBLISH] unless fully sanitised |
| Production configuration | [REDACTED] |
| Measured impact | [NEEDS DETAIL] if real numbers are not available |

## Business Context

The business issue was not the photo itself. The issue was inconsistent internal identity across Salesforce user interfaces.

Missing or stale User profile photos make ownership, collaboration and handover less clear, especially in teams that rely on Salesforce records for operational work. Manual profile maintenance does not scale well and creates avoidable administration.

## Solution Overview

The solution uses Salesforce-hosted automation to synchronise user profile images from Slack into Salesforce in a controlled way.

At a high level:

1. A scheduled Salesforce process identifies eligible users.
2. Apex retrieves approved Slack profile-photo data through a secure callout boundary.
3. User matching is handled by redacted internal logic.
4. Salesforce user photos are updated through supported platform mechanisms.
5. Errors are handled without logging secrets, tokens, raw identifiers or sensitive payloads.

## Architecture Summary

| Layer | Responsibility |
| --- | --- |
| Scheduled Apex | Starts the controlled synchronisation process |
| Batch Apex | Processes users in safe chunks to respect Salesforce governor limits and external limits |
| Apex service layer | Encapsulates Slack retrieval, matching and Salesforce update orchestration |
| Named Credential | Holds external authentication configuration outside code |
| Mocked callout tests | Validate behaviour without live Slack access or real user data |
| Redaction boundary | Prevents public exposure of credentials, org identifiers, usernames, email addresses and matching logic |

The architecture favours a Salesforce-native pattern to reduce operational surface area. External middleware is not required for the public pattern shown here.

## Security and Scalability Summary

Security controls shown or required:

| Control | Purpose |
| --- | --- |
| Named Credential | Keeps external authentication out of Apex code |
| No hard-coded secrets | Prevents token exposure through source control |
| Least-privilege integration access | Limits the blast radius of the Slack integration |
| Redacted matching logic | Avoids exposing private user-mapping rules |
| Mocked test data | Avoids real user data in public tests |
| Safe logging | Avoids tokens, raw identifiers, payloads and personal data in logs |
| Permission Sets | Provides explicit Salesforce access assignment where required |

Scalability controls shown or required:

| Control | Purpose |
| --- | --- |
| Batch Apex | Processes users in controlled chunks |
| Scheduled Apex | Provides predictable execution without manual admin effort |
| Service-layer separation | Keeps orchestration, callouts and update behaviour maintainable |
| Governor-limit awareness | Avoids synchronous bulk update risk |
| Mocked callouts | Keeps tests reliable and independent of Slack availability |

## Governance and Delivery

The public repository is treated as a redacted portfolio artefact.

Delivery principles:

- Sandbox-first build and validation.
- Source-controlled repository.
- Gearset promotion only if actually used in the private implementation.
- Peer review and regression testing before production deployment, where applicable.
- No live secrets, internal URLs, org identifiers or real user data in GitHub.
- Human publishing gate before making evidence public.

## Impact

[NEEDS DETAIL: measured impact requires real figures. Do not publish invented metrics.]

Observed impact:

Improved consistency of Salesforce User profile photos and reduced manual profile-photo maintenance. This is a cautious observed outcome, not a measured claim.

## What I Would Improve Next

Future evolution would include:

- A small admin-facing dashboard for sync status, skipped users and failures.
- More explicit retry visibility for failed photo retrieval or update attempts.
- Stronger operational reporting for rate-limit events and skipped records.
- A documented manual reprocessing path for selected users.
- More complete mocked setup guidance for portfolio reviewers.

## Recruiter Summary

This project shows practical Salesforce architecture thinking around a small but real operational problem. It combines business usability, secure integration design, controlled automation, source-control hygiene and public-safe redaction.

The value is in the design discipline: native Salesforce automation, secure Slack integration boundaries, non-disclosure of sensitive data and a maintainable pattern that can be explained clearly in interview.

## Technical Reviewer Summary

This project demonstrates a Salesforce-native integration pattern using scheduled and batch Apex, a service-layer boundary, mocked external callouts and secure configuration through Named Credentials.

The main design trade-off is deliberate: the public version prioritises safe architectural evidence over copyable production implementation. Sensitive matching logic, real identifiers, credentials and deployment details are intentionally excluded.

The repository should be reviewed as a redacted architecture case study, not as a deployable package.