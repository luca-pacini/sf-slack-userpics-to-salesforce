# Publish and polish

This repository is already linked to GitHub. Use the following commands for routine updates and to keep recruiter signals clear. No secrets or production data are required.

## Routine update (commit and push)

```bash
# From the repository root
git add .
git commit -m "Docs and code: recruiter signals refreshed"
git push -u origin main
```

## First‑time initialisation (only if starting a fresh local folder)

```bash
# Replace <your-username> and <repo-name>
export GITHUB_URL=https://github.com/<your-username>/<repo-name>

git init
git branch -M main
git add .
git commit -m "Initial commit: redacted case study"
git remote add origin "$GITHUB_URL"
git push -u origin main
```

## Repository description (suggested)

Slack to Salesforce Photos: Apex service and batch to sync user avatars using Named Credentials and ConnectApi. Redacted and demo‑safe.

## Suggested topics

salesforce, architecture, security, cicd, gearset

## Profile polish

* Pin this repository on your GitHub profile.
* Link it from your Portfolio Index with a one‑line value proposition:
  *Automated profile photo governance in Salesforce with high success and minimal admin effort.*

## IP notice

Case study. Redacted. No redistribution.
