# 🧩 Product Management

**Team:** Stephen Hyams (Director) · Sadie Kinne, Regina Robidoux, Masha Power, Lisa LaBarre (PMs) · Denise Johnson (Product Analyst)
**Theme:** idea → working prototype; killing documentation drudgery.

> 💡 This group often thinks *"I don't code."* That's exactly why the wow factor matters most here — and why **Demo 1 is the recommended session opener.**
>
> ⚠️ Synthetic data only. The notes and survey CSV here are fabricated.

---

## Demo 1 — PRD → clickable prototype ⭐ (flagship / session opener)

One-line: describe an internal tool and get a clean, working HTML mockup in seconds.

**Prompt:**
```text
Build a single-page HTML mockup of an internal 'Wish Tracker' tool: a table of wishes with status, assigned coordinator, and chapter, plus filters and a status badge. Make it look clean.
```

- **Files to open:** none required — this builds from a blank slate. Open the result in a browser to click around.
- **What to point out:** a real, styled single-page app appears — a wishes table with status badges, an assigned-coordinator and chapter column, and working filters — from one plain-English sentence. No setup, no framework wrangling.
- **Why it lands:** the "I don't code" audience watches a usable prototype materialize from a description. That's the moment the room leans in.

---

## Demo 2 — Notes → PRD

One-line: turn messy discovery notes into a structured one-page PRD.

**Prompt:**
```text
Turn the notes in discovery-notes.md into a one-page PRD with goals, user stories in 'As a… I want… so that…' format, and acceptance criteria.
```

- **Files to open:** [`discovery-notes.md`](discovery-notes.md) (raw, unstructured hallway/sync notes).
- **What to point out:** Claude Code reads genuinely messy input — double-entry pain, mobile/offline asks, broken search, inconsistent statuses across chapters, HIPAA/audit needs, role-based access — and organizes it into goals, properly formatted user stories, and testable acceptance criteria, without losing the constraints buried in the notes.
- **Why it lands:** hours of "clean up my notes into a PRD" collapse into one prompt — and the structure is genuinely usable.

---

## Demo 3 — Synthesize research

One-line: cluster open-ended survey feedback into the top pain points with evidence.

**Prompt:**
```text
Read survey_responses.csv, cluster the themes, and give me the top 5 pain points with a representative quote for each.
```

- **Files to open:** [`survey_responses.csv`](survey_responses.csv) (respondent role, satisfaction score, free-text feedback).
- **What to point out:** Claude Code clusters the free-text into recurring themes — double entry, slow load times, broken search, painful reporting/Excel exports, mobile access, stale cross-chapter sync — and returns the top 5 with a representative verbatim quote for each, instead of you reading 40 rows by hand.
- **Why it lands:** qualitative synthesis that normally eats an afternoon of tagging becomes an instant, quotable summary.

---

### ▶️ Run it
```bash
cd demos/product
claude
```
Then paste the **Demo 1** flagship prompt above.
