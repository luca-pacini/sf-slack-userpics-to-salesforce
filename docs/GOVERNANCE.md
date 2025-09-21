# Governance

This repository presents a redacted case study. It aligns with enterprise governance without exposing client specifics.

## TOGAF alignment (principles in practice)

* **Security by design**: least‑privilege scopes, Named Credential boundary (`NC_[SERVICE]_JWT`), no secrets in code.
* **Standardisation**: prefer native Salesforce capabilities (Apex, ConnectApi, Named Credentials); avoid bespoke runtimes.
* **Data ownership**: Slack is the source of truth for avatars; Salesforce presents the mastered image.
* **Reusability and modularity**: service class callable by batch, scheduler, or admin interface.
* **Transparent change**: version control, peer review, traceable releases.

## ITIL alignment (operations)

* **Change enablement**: peer‑reviewed pull requests; promotion via Gearset with evidence attached.
* **Incident management**: investigate error spikes; targeted reruns for affected users only.
* **Problem management**: rate‑limit back‑off and retry patterns reduce recurrence of transient failures.
* **Service level**: schedule during off‑peak; monitor batch outcomes and track KPIs from the README “Outcomes”.

## Environments and releases

* **Flow**: Development sandbox → Staging → Production.
* **Approvals**: mandatory peer review before promotion; change record references PR and deployment evidence.
* **Auditability**: commit hashes, deployment notes, and screenshots (blurred) stored alongside releases.

## Evidence and redaction

* Evidence artefacts are documented in **docs/EVIDENCE.md** and must follow **docs/REDACTION.md**.

## IP notice

Case study. Redacted. No redistribution.
