# Architecture Decision Records

This document includes only decisions that are defensible from the public portfolio context. Where implementation evidence is missing, the decision is marked accordingly.

## ADR-001 — Use Salesforce-hosted scheduled processing

### Context

Salesforce User profile photos needed to be synchronised from Slack without adding unnecessary operational infrastructure.

### Decision

Use Salesforce-hosted scheduled processing to initiate the synchronisation.

### Alternatives Considered

| Alternative | Reason not selected for the public pattern |
| --- | --- |
| External middleware job | Adds another runtime, ownership model and credential surface |
| Manual user updates | Does not scale and leaves inconsistency unresolved |
| One-off script | Weak auditability and repeatability |

### Consequences

The process stays close to the Salesforce data it updates and can be governed through Salesforce deployment and scheduling controls.

### Security Impact

Reduces the number of systems requiring access to Salesforce User data. Credentials still require careful handling through Named Credentials.

### Scalability Impact

Scheduled processing supports repeatable operation. Large user populations still require Batch Apex or equivalent chunking.

## ADR-002 — Use Named Credentials for Slack callout authentication

### Context

Slack API access requires authentication. Storing tokens in Apex, Custom Metadata Types or public configuration would create unacceptable exposure risk.

### Decision

Use Salesforce Named Credentials as the authentication boundary for Slack API callouts.

### Alternatives Considered

| Alternative | Reason not selected |
| --- | --- |
| Hard-coded Apex token | High exposure risk and poor rotation model |
| Custom Metadata Type token | Still exposes sensitive material through metadata and deployment history |
| Manual token injection in code | Not maintainable or auditable |

### Consequences

Credential management remains administrator-controlled and outside source control. The public repository can describe the pattern without including live secrets.

### Security Impact

Improves secret handling and supports rotation without code change.

### Scalability Impact

No direct scalability gain, but it keeps callout configuration manageable as the implementation evolves.

## ADR-003 — Use Batch Apex for controlled processing

### Context

User photo sync can involve multiple users and external callouts. A single synchronous transaction would be more fragile under Salesforce governor limits and Slack rate limits.

### Decision

Use Batch Apex to process eligible users in chunks.

### Alternatives Considered

| Alternative | Reason not selected |
| --- | --- |
| Single synchronous Apex execution | Higher risk of callout and DML limits |
| Manual per-user execution only | Lower operational value and weak scalability |
| External worker | Adds unnecessary infrastructure for the documented pattern |

### Consequences

Processing becomes more predictable and operationally manageable. Batch size must still be selected carefully.

### Security Impact

Batching does not remove the need for secure logging and least-privilege execution.

### Scalability Impact

Improves governor-limit control and supports larger user populations than a synchronous transaction.

## ADR-004 — Publish a redacted portfolio version

### Context

The project is intended to show Salesforce architecture capability publicly without exposing private implementation details.

### Decision

Publish a redacted portfolio version that explains the business problem, architecture, security boundary and trade-offs, while excluding sensitive configuration and identifiers.

### Alternatives Considered

| Alternative | Reason not selected |
| --- | --- |
| Publish full implementation | Risk of exposing secrets, mappings or internal details |
| Publish documentation only | Less useful for technical review |
| Keep repository private | Reduces portfolio value |

### Consequences

The repository is useful for architecture review but not intended for direct production deployment.

### Security Impact

Significantly reduces disclosure risk.

### Scalability Impact

No direct runtime impact, but it keeps the public artefact maintainable and reviewable.
