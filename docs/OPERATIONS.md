# Operations Runbook

This runbook explains how to operate the profile photo sync safely using mocked or non‑production data. No business logic, secrets, or internal identifiers are included.

## Schedule and batch sizing

* Recommended window: off‑peak hours.
* Safe batch size: **50–200** users per chunk (tune based on observed limits).
* Back‑off between chunks: **2–5 minutes** if rate limits are encountered.

## Monitoring

* Review Apex batch logs after each run: totals processed, succeeded, failed.
* Track failure reasons over time; investigate any spike over **5** failures per run.
* Maintain an operational diary noting run date, scope size, and notable errors.

## Failure modes and recovery

* **429 Too Many Requests**: reduce batch size; wait and retry remaining users.
* **Invalid or expired token**: rotate credentials in the Named Credential `NC_[SERVICE]_JWT` (admin only). Do not commit secrets.
* **No Slack mapping**: users missing `Slack_User_Id__c`; export list, correct mappings, rerun those users only.
* **Image fetch errors (3xx/4xx/5xx)**: retry a small number of times; if persistent, skip and record for manual review.

## Re‑queue and targeted reruns

* Rerun only the failed user IDs to minimise external calls and stay within limits.
* Avoid replaying successful users unless a global issue was identified and resolved.

## Safe verification steps

* Spot‑check 3–5 users post‑run: confirm a non‑default photo is displayed.
* Confirm absence of new unhandled exceptions in logs.
* If policy requires, verify that users cannot overwrite governed photos.

## Read‑only SOQL examples (dummy values)

```sql
/* Users with a Slack mapping (read only) */
SELECT Id, Name, Slack_User_Id__c
FROM User
WHERE IsActive = true AND Slack_User_Id__c != null
LIMIT 50

/* Recently updated photos (read only) */
SELECT Id, LastModifiedDate
FROM User
WHERE LastModifiedDate = LAST_N_DAYS:1
ORDER BY LastModifiedDate DESC
LIMIT 50
```

## Change control and evidence

* All changes promoted via Gearset with peer review and stored evidence.
* Attach screenshots (blurred) of successful runs and test results to the change record.

## IP and confidentiality

* **Case study. Redacted. No redistribution.**
* Use placeholders only: `[REDACTED]`, `[MOCKED]`, `[OBFUSCATED]`, `[DUMMY_CREDENTIAL]`, `ORG_XXXXX`, `https://api.example.local`, `NC_[SERVICE]_JWT`.
