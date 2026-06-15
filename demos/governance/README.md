# 🛡️ Data & Reporting / Governance

**Team:** Joey Wycoff · Demario Gonzalez (Data Governance Managers)
**Theme:** governance and data quality as code — HIPAA-relevant.

> ⚠️ Synthetic data only. `patients_sample.csv` uses fake names, fake MRNs (`MRN-FAKE-…`), and `example-notreal.org` emails. It exists *because* we must never test on real PHI.

---

## Demo 1 — PII/PHI scanner ⭐ (flagship)

One-line: scan a flat file and classify which columns carry PII or PHI.

**Prompt:**
```text
Write a Python script that scans patients_sample.csv and flags columns likely to contain PII or PHI — names, DOB, diagnosis, MRN — using pattern matching, and output a classification report.
```

- **Files to open:** [`patients_sample.csv`](patients_sample.csv) (in this folder).
- **What to point out:** Claude Code writes pattern-matching logic that correctly flags `full_name`, `date_of_birth`, `medical_record_number` (the `MRN-…` pattern), `diagnosis`, `email`, and `phone` — and recognizes `internal_notes` as free-text that can leak PHI too. The output is a per-column classification report (PII vs PHI vs low-risk).
- **Why it lands:** a repeatable, auditable PHI scanner — the kind of control governance is accountable for — generated in one prompt instead of a project.

---

## Demo 2 — Data-quality scorecard

One-line: profile a dirty dataset and score it across the dimensions that matter.

**Prompt:**
```text
Profile wishes_dataquality.csv: null rates per column, duplicate keys, out-of-range dates, and value distributions. Output a quality scorecard.
```

- **Files to open:** [`wishes_dataquality.csv`](wishes_dataquality.csv) (in this folder).
- **What to point out:** the file has injected defects Claude Code should surface:
  - **Duplicate primary keys** — `wish_id` 1004 and 1019 each appear twice.
  - **Nulls / missing values** — blank `child_first_name` (1003), missing `coordinator` (multiple rows), missing `cost_usd` (1009), missing `date_granted` (1011), missing `date_referred` (1030), blank `wish_type` (several rows).
  - **Out-of-range dates** — `date_referred` of `1900-01-01` (1002) and `date_granted` of `2099-12-31` (1014).
  - **Illogical date order** — `date_granted` *before* `date_referred` on several rows (e.g., 1000, 1008).
  - **Out-of-range numerics** — `days_to_grant` of `99999` (1025) and a negative `-15` (1008); `cost_usd` of `-2500.0` (1016) and `999999999.0` (1022).
  - **Inconsistent categoricals** — `chapter` recorded as `arizona` / `Az` / `Arizona` / `ARIZONA` and `North Texas` / `N. Texas`; `wish_type` as `go` / `HAVE` / `I wish to go`, etc.
- **Why it lands:** every defect a human would need hours of squinting to find shows up in a single scorecard, ranked and quantified.

---

## Demo 3 — Data catalog

One-line: turn a raw schema into a readable data dictionary.

**Prompt:**
```text
Read schema.sql and generate a data dictionary in markdown — table, column, type, and an inferred business description for each.
```

- **Files to open:** [`../bi/schema.sql`](../bi/schema.sql) (shared with BI).
- **What to point out:** Claude Code reads all six tables (`Chapters`, `Coordinators`, `Donors`, `Referrals`, `Wishes`, `WishDonations`), captures column names, types, keys, and foreign-key relationships, and *infers* a plain-English business description for each column — including noticing that `Referrals.ChildAlias` is a de-identified alias by design.
- **Why it lands:** a catalog that's usually perpetually out of date is generated directly from the source of truth, relationships and all.

---

### ▶️ Run it
```bash
cd demos/governance
claude
```
Then paste the **Demo 1** flagship prompt above.
