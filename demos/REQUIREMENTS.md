# ✅ Demo Requirements & Dependencies

What each cohort needs to run its demos — split into two honest tiers so you can pre-stage the room and avoid surprises mid-session.

> ⚠️ **Synthetic data only.** Every sample file is fabricated. Never substitute real PHI, donor, or wish-kid data — not in a prompt, not in a sample file. See the ground rule in the [facilitator landing page → README.md](../README.md).

---

## The two tiers

| Tier | Meaning |
|---|---|
| **To present** | The minimum to show the demo live and land the before→after. For almost every demo this is **just Claude Code + the cloned repo + the sample file** — the demo lands on Claude *generating* the artifact (a SQL rewrite, a Bicep file, a PowerShell script, an HTML mockup). No cloud account needed for the wow moment. |
| **To run for real** | What you additionally need to *execute* the generated artifact end-to-end — a runtime (Python/PowerShell) or a live cloud account/connection (Azure, Entra ID, Azure OpenAI, a SQL instance, Power BI). Only needed if a cohort wants to actually run the output, not just see it produced. |

**Friction tiers** used in the tables below:

- **A — fully local.** Browser or text only. Nothing to install; the output is its own proof.
- **B — local runtime, no cloud account.** Needs Python or PowerShell installed, but no subscription or tenant.
- **C — live cloud account/connection.** Needs Azure, Entra ID, Azure OpenAI, a SQL instance, or Power BI to run the output for real.

> 📌 **On the prompt's example — Azure vs. Intune:** No demo uses **Intune**. The Engineering onboarding demo provisions **Entra ID** users via the **Microsoft.Graph** PowerShell module — that's the connection that cohort needs to *run* the script, and even then only if they go past `-WhatIf`. Infra/Arch is the cohort that genuinely touches **Azure** (subscription for IaC, Azure OpenAI for the RAG prototype).

---

## Baseline — every cohort

Required for **all** demos, regardless of function:

1. **Claude Code** installed and authenticated.
2. The repo **cloned locally**.
3. `cd` into your function's folder (e.g. `cd demos/engineering`), then launch `claude`.

That's the whole floor. With just this, every cohort can *present* its demos. The per-function tables below add only what's needed to *run the output for real*.

> The repo intentionally ships **no `requirements.txt` or module manifests** — Claude Code can generate them on demand. The [Setup appendix](#setup-appendix) lists the exact installs if you want to pre-stage.

---

## 🧩 Product Management

**No extra setup — browser only.** All three demos are turnkey.

| Demo | To present | To run for real | Tier |
|---|---|---|---|
| 1 — PRD → prototype ⭐ | Claude Code + repo | A web browser to open the generated `.html` | **A** |
| 2 — Notes → PRD | Claude Code + `discovery-notes.md` | none — output is a Markdown doc | **A** |
| 3 — Synthesize research | Claude Code + `survey_responses.csv` | none — output is a text summary | **A** |

---

## 📊 Business Intelligence

The reverse-engineer demo is turnkey; the query and ETL demos need a SQL instance to *validate* (not to present).

| Demo | To present | To run for real | Tier |
|---|---|---|---|
| 1 — Optimize slow query ⭐ | Claude Code + `slow_query.sql` | SQL Server / Azure SQL with the schema + data loaded; SSMS or Azure Data Studio to run the rewrite and test the indexes | **C** |
| 2 — Reverse-engineer proc | Claude Code + `usp_WishSummary.sql` | *(optional)* a SQL instance to verify the lineage | **A** |
| 3 — ETL + DAX | Claude Code + `wishes_dataquality.csv` + `schema.sql` | Python 3 + `pandas` (+ `pyodbc`/`sqlalchemy` to load) + a SQL instance for the load; **Power BI Desktop** to test the DAX measures | **B + C** |

---

## 🏗️ InfraArch

The audit demo is turnkey. The IaC and RAG demos are where **Azure** comes in — and only to run the output, not to present it.

| Demo | To present | To run for real | Tier |
|---|---|---|---|
| 1 — Scaffold compliant IaC ⭐ | Claude Code | Bicep CLI to lint (`az bicep build`); an **Azure subscription** + Azure CLI to actually deploy | **C** |
| 2 — Audit `main.bicep` | Claude Code + `main.bicep` | *(optional)* Azure to run a real scanner against it | **A** |
| 3 — RAG prototype (Joseph) | Claude Code | Python 3 + `openai` + a RAG lib (LangChain/LlamaIndex); an **Azure OpenAI** resource + model deployment, key in `AZURE_OPENAI_API_KEY` | **C** |

---

## ⚙️ Engineering

Debug and tests run locally with just PowerShell. The flagship runbook→script demo only needs an **Entra ID** connection if you execute past `-WhatIf` — **not Intune**.

| Demo | To present | To run for real | Tier |
|---|---|---|---|
| 1 — Runbook → script ⭐ | Claude Code + `onboarding-runbook.md` | PowerShell 7+ + the `Microsoft.Graph` module + an **Entra ID** tenant/test account (run with `-WhatIf` first; live execution needs `Connect-MgGraph` and admin consent) | **C** |
| 2 — Debug fast | Claude Code + `Provision-NewUser.ps1` | PowerShell 7+ (no cloud — you can even just read the errors) | **B** |
| 3 — Add tests | Claude Code + `Provision-NewUser.ps1` | PowerShell 7+ + `Pester` (tests mock the Graph cmdlets — no tenant needed) | **B** |

---

## 🛡️ Governance

Two demos need only Python; the data-catalog demo is fully local.

| Demo | To present | To run for real | Tier |
|---|---|---|---|
| 1 — PII/PHI scanner ⭐ | Claude Code + `patients_sample.csv` | Python 3 — **standard library only** (`re`, `csv`); no packages | **B** |
| 2 — Data-quality scorecard | Claude Code + `wishes_dataquality.csv` | Python 3 + `pandas` | **B** |
| 3 — Data catalog | Claude Code + `../bi/schema.sql` | *(optional)* a SQL instance to verify | **A** |

---

## Sequencing the live session

Lead with turnkey demos to keep momentum; save account-gated demos for a deep dive or a pre-provisioned hands-on lab.

- **Turnkey (Tier A — show with zero setup):** all of Product · BI 2 · InfraArch 2 · Governance 3
- **Runtime only (Tier B — one local install):** Engineering 2 & 3 (PowerShell) · Governance 1 & 2 (Python)
- **Account-gated (Tier C — needs a live connection to run):** BI 1 & 3 (SQL / Power BI) · InfraArch 1 & 3 (Azure / Azure OpenAI) · Engineering 1 (Entra ID)

---

## Setup appendix

Each entry maps to the demos that need it. You only need these to **run outputs for real** — none are required to present.

### Claude Code *(baseline — all demos)*
Installed and authenticated. Repo cloned. `cd` into the function folder and run `claude`.

### Python 3.x + pip *(Governance 1 & 2, BI 3, InfraArch 3)*
- `pandas` — BI 3 (ETL), Governance 2 (scorecard)
- `pyodbc` or `sqlalchemy` — BI 3, to load the cleaned data into SQL
- `openai` + a RAG library (LangChain or LlamaIndex) — InfraArch 3
- Governance 1 needs **no packages** — standard library only.
- Tip: ask Claude to generate a `requirements.txt` for any demo.

### PowerShell 7+ *(Engineering, all three)*
- `Microsoft.Graph` module — `Install-Module Microsoft.Graph` (Engineering 1; useful context for 2)
- `Pester` — `Install-Module Pester` (Engineering 3; often preinstalled)

### Azure *(InfraArch 1 & 3)*
- An **Azure subscription** + **Azure CLI** (`az login`)
- Bicep CLI — `az bicep install` (lint/build without deploying)
- **Azure OpenAI** resource with a model deployment + endpoint/key for InfraArch 3; store the key in `AZURE_OPENAI_API_KEY`

### Entra ID *(Engineering 1 — not Intune)*
- A **test Entra ID tenant** (never a production one) and an account with directory write access
- Graph scopes for live execution: `User.ReadWrite.All`, `Group.ReadWrite.All` (granted via `Connect-MgGraph -Scopes ...`)
- Always demo with `-WhatIf` first.

### SQL *(BI 1 & 3; optional for BI 2, Governance 3)*
- **Azure SQL Database** or a local **SQL Server / LocalDB / SQL Server Express**
- A client: **Azure Data Studio** or **SSMS**
- Load [`bi/schema.sql`](bi/schema.sql) (and seed sample rows) so queries have something to run against

### Power BI Desktop *(BI 3 — DAX step)*
Free download; needed only to test the generated DAX measures.

---

🔙 Back to [Demos by Function → README.md](README.md) · 🏠 [Facilitator landing page → README.md](../README.md) · 🕐 [Run of show → AGENDA.md](../AGENDA.md)
