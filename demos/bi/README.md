# 📊 Business Intelligence

**Team:** Jeff Spencer (Sr Mgr, Data Architecture) · Jessica Geiger & Guled Hersi (Sr BI Devs) · Asad Syed (BI Dev)
**Theme:** SQL, DAX, pipelines, and documenting the undocumented.

> ⚠️ Synthetic data only. All tables, queries, and CSVs here are fabricated.

---

## Demo 1 — Optimize a slow query ⭐ (flagship)

One-line: hand over a query that scans on purpose and get a tuned rewrite plus an index plan.

**Prompt:**
```text
Rewrite slow_query.sql for performance, explain what was causing the table scan, and suggest the indexes I should add.
```

- **Files to open:** [`slow_query.sql`](slow_query.sql) (in this folder).
- **What to point out:** the query has every classic anti-pattern, and Claude Code names them: **`SELECT *`**, **functions on WHERE columns** (`YEAR(w.DateReferred)`, `UPPER(c.ChapterName)`, `DATEDIFF(...)`) that kill sargability, an **implicit type conversion on the join** (`CONVERT(VARCHAR(50), w.ChapterId) = c.ChapterCode`), a **leading-wildcard `LIKE '%ARIZONA%'`**, and a **correlated subquery in the `ORDER BY`** that re-runs per row. Watch it rewrite to sargable predicates and recommend concrete covering/supporting indexes.
- **Why it lands:** it explains *why* each smell forces a scan — teaching, not just rewriting — and hands back the exact `CREATE INDEX` statements.

---

## Demo 2 — Reverse-engineer a stored proc

One-line: turn an undocumented stored procedure into wiki-ready plain English.

**Prompt:**
```text
Read usp_WishSummary.sql and produce a plain-English explanation of what it does, its inputs/outputs, and a data-lineage summary I can drop into our wiki.
```

- **Files to open:** [`usp_WishSummary.sql`](usp_WishSummary.sql) (in this folder).
- **What to point out:** Claude Code traces the whole proc — the `@FiscalYear`/`@ChapterCode` inputs, the Sept-1 fiscal-year window, the temp-table staging (`#base` → `#agg` → `#coord`), the per-chapter aggregation, the "top coordinator" subquery, and the final result set — and writes a lineage summary (Wishes/Chapters/Coordinators → output columns) you can paste straight into the wiki.
- **Why it lands:** the documentation nobody ever has time to write appears in one pass, accurate to the actual logic.

---

## Demo 3 — ETL + DAX

One-line: ingest and clean a messy CSV, then generate the DAX measures on top.

**Prompt (step 1 — ETL):**
```text
Write a Python script that ingests wishes_dataquality.csv, cleans the date and chapter columns, and loads it into a SQL table
```

**Prompt (step 2 — DAX):**
```text
write the DAX measures for YoY wishes-granted growth and average days-to-grant by chapter.
```

- **Files to open:** [`../governance/wishes_dataquality.csv`](../governance/wishes_dataquality.csv) (shared with Governance) and [`schema.sql`](schema.sql) for the target table shapes.
- **What to point out:** the CSV's `chapter` column is a mess — `arizona`, `Az`, `Arizona`, `ARIZONA`, `North Texas` vs `N. Texas`, `greater la` — and the dates include junk like `1900-01-01` and `2099-12-31`. Claude Code writes cleaning logic to normalize chapter names and coerce/validate dates before load, then produces correct DAX for year-over-year growth and average days-to-grant by chapter.
- **Why it lands:** the full pipeline — dirty CSV → clean SQL table → reportable measures — comes together across two prompts, end to end.

---

## ✅ Requirements / Setup

**Baseline (all demos):** Claude Code installed & authenticated, the repo cloned, then `cd demos/bi`. That alone is enough to **present** every demo — Claude generates the rewrite, the docs, and the scripts without a database.

**To run the output for real:**

| Demo | To run the output for real | Tier |
|---|---|---|
| 1 — Optimize slow query | SQL Server / Azure SQL with the schema + data loaded; SSMS or Azure Data Studio to run the rewrite and test indexes | C — cloud/DB |
| 2 — Reverse-engineer proc | *(optional)* a SQL instance to verify the lineage | A — local |
| 3 — ETL + DAX | Python 3 + `pandas` (+ `pyodbc`/`sqlalchemy`) + a SQL instance to load; **Power BI Desktop** to test the DAX | B + C |

Full cross-cohort matrix and setup steps: [../REQUIREMENTS.md](../REQUIREMENTS.md).

---

### ▶️ Run it
```bash
cd demos/bi
claude
```
Then paste the **Demo 1** flagship prompt above.
