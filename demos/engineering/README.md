# ⚙️ Engineering

**Team:** Tyler Nelson (IT Engineering Mgr) · Scott Goodman (Engineer) · Craig Schettler (Systems Administrator)
**Theme:** automating repetitive ops and admin work.

> ⚠️ Synthetic data only. The script and runbook here are fabricated demo artifacts. Do not run the script against a real tenant.

---

## Demo 1 — Runbook → script ⭐ (flagship)

One-line: hand the agent a manual checklist and get a safe, documented automation script back.

**Prompt:**
```text
Read onboarding-runbook.md and write a PowerShell script that automates the Entra ID steps — create the user, assign the license group, add to the right security groups. Add comment-based help and a -WhatIf safety switch.
```

- **Files to open:** [`onboarding-runbook.md`](onboarding-runbook.md) (the manual process).
- **What to point out:** Claude Code reads the runbook's steps — create user, set a 12-char temp password with force-change, add to the `Dept-<Department>` group, confirm an E3 seat is free before assigning — and turns them into a Microsoft.Graph script with proper comment-based help (`.SYNOPSIS`/`.DESCRIPTION`) and a working `-WhatIf` switch so nothing fires by accident.
- **Why it lands:** a documented, safety-checked script materializes straight from the checklist the team already maintains.

---

## Demo 2 — Debug fast

One-line: a script that throws on every run — let the agent find and fix the root causes.

**Prompt:**
```text
Provision-NewUser.ps1 fails when I run it. Find the root cause(s), fix them, and explain what was wrong.
```

- **Files to open:** [`Provision-NewUser.ps1`](Provision-NewUser.ps1) (in this folder).
- **What to point out:** the script has **four planted bugs** Claude Code should catch and explain:
  1. **`New-MgUser -DisplayNam`** (line 39) — misspelled parameter name; should be `-DisplayName`.
  2. **`$($NewUsr.UserPrincipalName)`** (line 46) — references a non-existent variable; the user was stored in `$newUser`, so the `Write-Host` prints nothing.
  3. **No null check on `$group`** (around lines 49–53) — if `Get-MgGroup` finds no `Dept-<Department>` group, `$group.Id` is null and `Add-MgGroupMember` fails with an unhelpful error.
  4. **Inverted license logic** (line 58) — `if ($availableLicenses -lt 0)` should be `-gt 0`; as written it *skips* assigning a license when seats actually exist.
- **Why it lands:** the agent doesn't just fix the obvious typo — it catches the silent logic bug (#4) that would quietly leave new hires unlicensed.

---

## Demo 3 — Add tests

One-line: generate a test suite that covers the happy path and realistic failures.

**Prompt:**
```text
Generate Pester tests for the user-provisioning function covering the happy path and two failure cases.
```

- **Files to open:** [`Provision-NewUser.ps1`](Provision-NewUser.ps1) for context (the function under test).
- **What to point out:** Claude Code writes Pester tests that mock the Graph cmdlets and assert the happy path plus failure cases — e.g., the security group not existing, or no license seats available — exactly the scenarios the runbook warns about.
- **Why it lands:** test coverage for an ops script — usually the first thing skipped — appears in seconds, in the right framework.

---

## ✅ Requirements / Setup

**Baseline (all demos):** Claude Code installed & authenticated, the repo cloned, then `cd demos/engineering`. That alone is enough to **present** every demo — Claude writes, fixes, and tests the script without a tenant.

**To run the output for real:**

| Demo | To run the output for real | Tier |
|---|---|---|
| 1 — Runbook → script | PowerShell 7+ + the `Microsoft.Graph` module + an **Entra ID** test tenant/account (demo with `-WhatIf`; live execution needs `Connect-MgGraph` + admin consent) | C — cloud |
| 2 — Debug fast | PowerShell 7+ (no cloud — you can even just read the errors) | B — runtime |
| 3 — Add tests | PowerShell 7+ + `Pester` (tests mock the Graph cmdlets — no tenant) | B — runtime |

> 📌 This cohort connects to **Entra ID** (Microsoft Graph), **not Intune**. And only Demo 1 needs it — only if you run past `-WhatIf`.

Full cross-cohort matrix and setup steps: [../REQUIREMENTS.md](../REQUIREMENTS.md).

---

### ▶️ Run it
```bash
cd demos/engineering
claude
```
Then paste the **Demo 1** flagship prompt above.
