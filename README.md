# 🚀 Agentic Coding with Claude Code — Familiarization Session

*A clone-and-go facilitation kit for the Make-A-Wish America IT Enablement Cohort.*

---

## 🤖 What is agentic coding?

Agentic coding is not autocomplete. Claude Code reads your actual files, runs commands in your terminal, and writes or edits code across a whole project — then checks its own work and iterates until the task is done. Instead of typing code line by line, you describe the outcome you want in plain English and let the agent do the multi-step work. The goal of this session is simple: learn to **delegate multi-step technical work** to an agent, so you spend your time on judgment instead of drudgery.

---

> ## ⚠️ Ground Rule: Synthetic Data Only
>
> **Every demo in this repo uses synthetic, non-production data.** We handle eligibility and medical PHI every day — **never paste real wish-kid, donor, or patient data into a demo.** All sample files in this repository are **100% fabricated** (fake names, fake MRNs, fake chapters). When you move from the session to real work, keep this rule: no production PHI in prompts.

---

## 👥 The Cohort

5 functions, 18 people.

| Function | Focus | People |
|---|---|---|
| 🧩 Product Management | Idea → working prototype | 6 |
| 📊 Business Intelligence | SQL, DAX, pipelines | 4 |
| 🏗️ InfraArch | Infrastructure-as-Code, Azure governance | 3 |
| ⚙️ Engineering | Automating ops & admin work | 3 |
| 🛡️ Data & Reporting / Governance | Quality & governance as code | 2 |

---

## 🗺️ Repository Map

```
claude-code-familiarization/
├── README.md                  ← you are here (facilitator landing page)
├── AGENDA.md                  ← 60-minute run of show
├── .gitignore
├── docs/
│   └── facilitation-guide.html  ← full leave-behind facilitation guide
└── demos/
    ├── README.md                ← index of all function demos
    ├── infraarch/               ← IaC, Azure governance, AI prototyping
    ├── engineering/             ← runbook→script, debugging, tests
    ├── bi/                      ← query tuning, stored-proc docs, ETL+DAX
    ├── governance/              ← PII/PHI scanning, data-quality scorecards
    └── product/                 ← PRD→prototype, notes→PRD, research synthesis
```

- **Demos by function:** [Product](demos/product/) · [BI](demos/bi/) · [InfraArch](demos/infraarch/) · [Engineering](demos/engineering/) · [Governance](demos/governance/)
- **Demo index:** [demos/README.md](demos/README.md)
- **Full facilitation guide:** [docs/facilitation-guide.html](docs/facilitation-guide.html)
- **Run of show:** [AGENDA.md](AGENDA.md)

---

## ⚡ Quickstart

1. **Clone the repo** and open it (locally or on GitHub).
2. **Install Claude Code** — follow the official docs: <https://docs.claude.com/en/docs/claude-code>
3. **`cd` into your function's demo folder**, e.g. `cd demos/product`
4. **Launch** the agent: `claude`
5. **Copy the prompt** from that folder's `README.md` and paste it in. Watch it go.

---

## 🎤 Facilitation Tips

- **Pre-stage nothing extra.** Everything you need is in this repo — the prompts, the sample files, the guide. Clone it and you're ready.
- **Show one clear before → after per demo.** Open the messy input file first (the slow query, the buggy script, the dirty CSV), run the prompt, then show the result. The contrast is the wow.
- **Lead with Product Management.** The PRD → clickable prototype demo has the highest wow factor and works best as the opener — especially for folks who think "I don't code."
- **Close with a commitment.** Have each person name **one real task from their week** they'll try with Claude Code next. That turns a demo into adoption.

---

📋 **Next:** open the [60-minute run of show → AGENDA.md](AGENDA.md)
