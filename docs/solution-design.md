# Solution Design

## Business Problem

Salesforce User profile photos were incomplete or inconsistent, making record ownership and internal collaboration less recognisable for users working in Salesforce.

The problem was operational identity consistency, not cosmetic polish.

## Current State

Before the controlled synchronisation pattern:

- Salesforce User photos could be blank, stale or inconsistent.
- Manual maintenance did not scale well.
- Slack already held profile-photo data for internal users.
- Any automation needed to avoid exposing Slack tokens, Salesforce identifiers or user-mapping detail.

## Target State

The target state is a controlled Salesforce-native process that:

- Identifies eligible Salesforce users.
- Retrieves approved Slack profile-photo data through a secure callout boundary.
- Applies the photo to the corresponding Salesforce User profile.
- Uses mocked data in public examples.
- Avoids hard-coded credentials and sensitive logging.
- Remains supportable through scheduled execution and clear failure handling.

## Users

Primary users:

- Salesforce users who benefit from clearer ownership and recognisable user profiles.
- Salesforce administrators who otherwise maintain profile images manually.
- Platform owners reviewing integration risk and supportability.

Specific business teams are intentionally not named in this public version.

## Core Components

| Component | Responsibility |
| --- | --- |
| Scheduled Apex | Starts the synchronisation process on a controlled schedule |
| Batch Apex | Processes users in governor-limit-safe chunks |
| Apex service layer | Coordinates Slack retrieval, matching and Salesforce update handling |
| Named Credential | Holds external authentication configuration outside code |
| Mocked callout tests | Validate behaviour without live Slack API access |
| Redaction boundary | Removes identifiers, credentials and internal mapping detail from public artefacts |

## Data Flow

1. Scheduled Apex starts the sync.
2. Batch Apex selects eligible users.
3. The service layer prepares a Slack lookup using redacted matching logic.
4. Slack photo data is retrieved through a secure callout boundary.
5. Salesforce updates the relevant User photo through supported platform mechanisms.
6. Errors are handled without logging tokens, raw identifiers, real email addresses or payloads.

## User Experience

The intended user experience is passive:

- Users do not manage the sync directly.
- Salesforce profile images become more consistent over time.
- Administrators retain control over schedule, configuration and failure review.

## Support Model

The support model should include:

- Review of scheduled job status.
- Review of failed or skipped users.
- Manual correction of missing mappings where needed.
- Credential rotation outside source control.
- Rerun of selected users or the next scheduled batch.

## Known Constraints

| Constraint | Handling |
| --- | --- |
| Slack API limits | Use controlled batch sizing and retry-aware design |
| Salesforce governor limits | Use Batch Apex rather than one large synchronous process |
| Sensitive user identifiers | Redact from public repository |
| Live credentials | Store outside code through Named Credentials |
| Public portfolio safety | Exclude production configuration and exact mapping rules |
| Real measured impact | Mark as [NEEDS DETAIL] unless supported by real evidence |
