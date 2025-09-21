# Evidence Pack

All artefacts must be anonymised and redacted. Use only mocked or obfuscated materials in public repositories.

## Contents to capture (portfolio‑safe)

* **BEFORE.png**: Salesforce user record with a default/blank photo. Blur faces and names. Crop to the photo area if required.
* **AFTER.png**: Same user with the synced avatar applied. Blur faces and names.
* **SYNC\_DEMO.gif** (10–20 seconds): screen capture of a single‑user sync using mocked data. Show: selecting the user → triggering the service → visible success indicator.
* **TESTS.png**: screenshot of green Apex tests for `SlackPhotoServiceTest` on mocked callouts. Display overall coverage only.

## Redaction and naming rules

* Filenames must not include individuals’ names, emails, or internal IDs.
* Blur faces and any personal identifiers in all images.
* Replace any visible org identifier with **ORG\_XXXXX**.
* If a URL appears, mask it as `https://api.example.local`.
* Do not include timestamps, ticket numbers, environment names, or hostnames.

## Storage layout

Create a dedicated evidence folder:

```
docs/
  evidence/
    BEFORE.png
    AFTER.png
    SYNC_DEMO.gif
    TESTS.png
```

## Capture guidance

* Use a non‑production org or mocked data only.
* Keep GIF length **≤ 20 seconds**; target **\~15 seconds**.
* Avoid showing record lists or dashboards; focus on the photo area and result indicators.

## Statement

These artefacts are illustrative only and do not represent client data. They exist solely to evidence approach and outcomes.
