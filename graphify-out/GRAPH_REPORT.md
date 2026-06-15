# Graph Report - .  (2026-06-15)

## Corpus Check
- Corpus is ~8,089 words - fits in a single context window. You may not need a graph.

## Summary
- 28 nodes · 55 edges · 6 communities (5 shown, 1 thin omitted)
- Extraction: 91% EXTRACTED · 9% INFERRED · 0% AMBIGUOUS · INFERRED: 5 edges (avg confidence: 0.76)
- Token cost: 55,000 input · 3,015 output

## Community Hubs (Navigation)
- [[_COMMUNITY_BI SQL Data Model|BI SQL Data Model]]
- [[_COMMUNITY_User Provisioning & Bugs|User Provisioning & Bugs]]
- [[_COMMUNITY_Session Structure & Demo Index|Session Structure & Demo Index]]
- [[_COMMUNITY_Session Framing & Agentic Coding|Session Framing & Agentic Coding]]
- [[_COMMUNITY_Product Discovery (Wish Tracker)|Product Discovery (Wish Tracker)]]
- [[_COMMUNITY_Project Settings|Project Settings]]

## God Nodes (most connected - your core abstractions)
1. `Wishes Table` - 9 edges
2. `60-Minute Run of Show` - 8 edges
3. `Engineering Demos` - 8 edges
4. `Demos by Function Index` - 7 edges
5. `Chapters Table` - 6 edges
6. `Slow Query (anti-pattern demo)` - 5 edges
7. `usp_WishSummary Stored Procedure` - 5 edges
8. `Familiarization Session (landing page)` - 5 edges
9. `Business Intelligence Demos` - 5 edges
10. `Coordinators Table` - 4 edges

## Surprising Connections (you probably didn't know these)
- `Wish Tracker Tool` --semantically_similar_to--> `Wishes Table`  [INFERRED] [semantically similar]
  demos/product/discovery-notes.md → demos/bi/schema.sql
- `Facilitation Guide & Demo Playbook` --conceptually_related_to--> `60-Minute Run of Show`  [INFERRED]
  docs/facilitation-guide.html → AGENDA.md
- `Synthetic Data Only Ground Rule` --rationale_for--> `Wish Tracker Tool`  [INFERRED]
  README.md → demos/product/discovery-notes.md
- `Governance Demos` --references--> `Wishes Table`  [EXTRACTED]
  demos/governance/README.md → demos/bi/schema.sql
- `New User Onboarding Runbook` --conceptually_related_to--> `Bug: inverted license-availability comparison`  [INFERRED]
  demos/engineering/onboarding-runbook.md → demos/engineering/Provision-NewUser.ps1

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Wish data model shared across BI demos** — bi_schema_wishes, bi_slow_query_slowquery, bi_usp_wishsummary_usp_wishsummary [INFERRED 0.85]
- **Runbook-to-script onboarding automation flow** — engineering_onboarding_runbook_onboardingrunbook, engineering_provision_newuser_provisionnewuser, engineering_readme_engineering [INFERRED 0.85]
- **Session facilitation kit** — readme_familiarization_session, agenda_run_of_show, docs_facilitation_guide_facilitationguide, demos_demos_index [INFERRED 0.85]

## Communities (6 total, 1 thin omitted)

### Community 0 - "BI SQL Data Model"
Cohesion: 0.50
Nodes (9): Business Intelligence Demos, Chapters Table, Coordinators Table, Donors Table, Referrals Table, WishDonations Table, Wishes Table, Slow Query (anti-pattern demo) (+1 more)

### Community 1 - "User Provisioning & Bugs"
Cohesion: 0.57
Nodes (6): New User Onboarding Runbook, Bug: misspelled -DisplayNam parameter, Bug: inverted license-availability comparison, Bug: wrong variable $NewUsr reference, Bug: missing null check on $group, Engineering Demos

### Community 2 - "Session Structure & Demo Index"
Cohesion: 0.83
Nodes (4): 60-Minute Run of Show, Demos by Function Index, Governance Demos, InfraArch Demos

### Community 3 - "Session Framing & Agentic Coding"
Cohesion: 0.83
Nodes (4): Agentic Coding, Facilitation Guide & Demo Playbook, Familiarization Session (landing page), Synthetic Data Only Ground Rule

### Community 4 - "Product Discovery (Wish Tracker)"
Cohesion: 1.00
Nodes (3): Wish Tracker Discovery Notes, Product Management Demos, Wish Tracker Tool

## Knowledge Gaps
- **1 isolated node(s):** `Project local settings`
  These have ≤1 connection - possible missing edges or undocumented components.
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Engineering Demos` connect `User Provisioning & Bugs` to `Session Structure & Demo Index`?**
  _High betweenness centrality (0.355) - this node is a cross-community bridge._
- **Why does `60-Minute Run of Show` connect `Session Structure & Demo Index` to `BI SQL Data Model`, `User Provisioning & Bugs`, `Session Framing & Agentic Coding`, `Product Discovery (Wish Tracker)`?**
  _High betweenness centrality (0.298) - this node is a cross-community bridge._
- **Why does `Wishes Table` connect `BI SQL Data Model` to `Session Structure & Demo Index`, `Product Discovery (Wish Tracker)`?**
  _High betweenness centrality (0.270) - this node is a cross-community bridge._
- **What connects `Project local settings` to the rest of the system?**
  _1 weakly-connected nodes found - possible documentation gaps or missing edges._