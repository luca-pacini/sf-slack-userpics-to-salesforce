# Governance

## TOGAF guardrails

* **Security by design**: least privilege scopes, Named Credential boundary, strict redaction policy.
* **Standardisation**: prefer native Salesforce capabilities (Apex, Named Credentials, ConnectApi) to reduce platform variance.
* **Reusability**: service class exposes a single entry point usable by batch, scheduler, or an admin UI.
* **Transparency**: version control, peer review, and test evidence for all changes.

## DevOps and change governance

* **Version control**: GitHub as the system of record.
* **CI/CD**: Gearset pipelines promote to higher environments; GitHub PRs capture review and approvals.
* **Evidence**: PR comments, test results, and Gearset deployment notes recorded per release.

## Environments and releases

* **Flow**: Dev sandbox → Staging → Production.
* **Approvals**: peer review required before promotion; change record linked to the PR.
* **Audit and traceability**: commit hashes, deployment IDs, and release notes aligned to work items.

## Operational governance (ITIL alignment)

* **Change enablement**: scheduled releases with rollback plans.
* **Incident management**: failed batches surfaced via logs; rerun restricted to the affected subset.
* **Problem management**: rate limit backoff and retry strategies reduce recurrence of transient failures.
