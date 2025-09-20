```mermaid
flowchart TD
  User --> Salesforce
  Salesforce -->|Event| Queue
  Queue --> External_System
```
