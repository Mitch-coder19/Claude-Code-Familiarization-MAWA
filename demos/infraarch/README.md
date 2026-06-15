# 🏗️ InfraArch — Infrastructure Architecture

**Team:** Eric Anglin (Infrastructure Architect) · Joseph Socarras (AI Engineer)
**Theme:** Infrastructure-as-Code, Azure governance, AI prototyping.

> ⚠️ Synthetic data only. `main.bicep` here is a fabricated sample with **deliberate** misconfigurations. Do not deploy it.

---

## Demo 1 — Scaffold compliant Azure IaC ⭐ (flagship)

One-line: generate a governed Azure stack from a plain-English description, including naming convention, tags, and a secure-by-default Key Vault.

**Prompt:**
```text
Create a Bicep template for a standard Azure App Service + Key Vault + Storage account. Apply our naming convention maw-<env>-<app>-<resource>, tag everything with CostCenter, Owner, and Environment, and make the Key Vault deny public network access by default.
```

**Follow-up prompt:**
```text
Now add a Log Analytics workspace and wire diagnostic settings to it.
```

- **Files to open:** none required — this builds from scratch. (Optionally contrast against the messy `main.bicep` in this folder.)
- **What to point out:** Claude Code produces valid Bicep with the naming convention applied consistently, the three required tags on every resource, `publicNetworkAccess: 'Disabled'` on the Key Vault, and — on the follow-up — diagnostic settings wired to a new Log Analytics workspace without you writing a line.
- **Why it lands:** governance that usually takes a half-day of template-wrangling appears in seconds, correctly tagged and secure by default.

---

## Demo 2 — Audit existing infra

One-line: point the agent at a real-looking Bicep file and get a ranked security review.

**Prompt:**
```text
Review main.bicep for security misconfigurations and untagged resources, and summarize the top 5 risks ranked by severity.
```

- **Files to open:** [`main.bicep`](main.bicep) (in this folder).
- **What to point out:** the file has planted issues Claude Code should surface — a **Storage account with `allowBlobPublicAccess: true`**, **HTTP allowed (`supportsHttpsTrafficOnly: false`) and TLS 1.0**, a **Key Vault with `publicNetworkAccess: 'Enabled'`** and purge protection off, **hardcoded secrets** (a `sqlAdminPassword` default and a connection string in a `var`, even leaked via an `output`), an **NSG rule opening RDP/3389 to `*` (the internet)**, and **no tags or diagnostic settings on any resource**. Watch it rank these by severity rather than just listing them.
- **Why it lands:** it reads code like a senior reviewer — catching the internet-facing RDP rule and the leaked secret that a quick human skim would miss.

---

## Demo 3 — AI agent scaffold (Joseph)

One-line: stand up a minimal RAG prototype from one sentence.

**Prompt:**
```text
Build a minimal Python RAG prototype: load these sample .txt files, chunk and embed them, and answer a question against them. Use Azure OpenAI and keep the API key in an env var.
```

- **Files to open:** none required — Claude Code will scaffold the project (and can create sample `.txt` files to load).
- **What to point out:** a runnable project structure appears — loading, chunking, embedding, retrieval, and a query loop — with the API key read from an environment variable instead of hardcoded.
- **Why it lands:** an AI prototype that normally needs a tutorial and an afternoon becomes a working starting point in one prompt.

---

### ▶️ Run it
```bash
cd demos/infraarch
claude
```
Then paste the **Demo 1** flagship prompt above.
