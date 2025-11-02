# 🌐 DFWSC Agent Framework – Global Conventions

**Purpose:** This document is the single source of truth for how agents behave, how progress is logged, how commits are written, and how handoffs/resumes work.

**Applies to:** All agents under `dfwsc_agents/agents/*` and all progress/handoff assets under `.claude/progress/*`.

---

## 1) Agent Taxonomy & Roles

- **Progress Agent** (`/agents use progress`)
  - Reads staged/HEAD diff, updates `ticket-progress.md`, may update `project-progress.md` when a phase completes, suggests conventional commit, prints `git add/commit/push`.
- **Handoff Agent** (`/agents use handoff` or `progress` with `Mode: save`)
  - Writes checkpoint to `.claude/progress/checkpoints/<timestamp>.md`, updates `.claude/progress/RESUME.md`, optionally appends a `[Save]` marker in ticket log. **No commits.**
- **Resume Agent** (`/agents use resume`)
  - Loads `.claude/progress/RESUME.md`, reads latest checkpoint, restores context summary and next steps. **No writes to progress logs.**
- **Locator / Analyzer / Synthesis / Anti-patterns / Dead-code**
  - Read-only analysis roles whose outputs are written as comments, reviews, or issue drafts; they do **not** modify progress files.

> Agents **must not** invent conventions. They **must** conform to this file.

---

## 2) Directory Layout (canonical)

```
.claude/
progress/
project-progress.md
ticket-progress.md
checkpoints/
YYYY-MM-DD_HHMMSS.md
RESUME.md
progress_archive/            # optional, for rotation
dfwsc_agents/
agents/
progress/CLAUDE.md
handoff/CLAUDE.md
resume/CLAUDE.md
analyzer/...
locator/...
synthesis/...
router/
custom-router.js
scripts/
rotate_progress.sh
templates/
phase.md
ticket-goal.md
project-goal.md
retro.md
global.md                        # THIS FILE
````

---

## 3) Phases, Status & Colors

- **Phase naming:** `Phase 1 – Setup`, `Phase 2 – Implementation`, `Phase 3 – Validation`, `Phase 4 – Release`.
- **Status emojis:**
  - 🟢 Complete
  - 🟡 In progress
  - 🔴 Blocked
- **Agent color legend (for specs UI only):**
  - `teal` → Resume
  - `amber` → Handoff
  - `green` → Progress
  - `blue` → Locator/Analyzer/Synthesis
  - `red` → Anti-patterns / Security

---

## 4) Progress Files — Required Formats

### 4.1 `project-progress.md` (big-picture)
Minimal required sections (append/update in place):

```markdown
# Project Progress — <Project Name>
**Ultimate Goal:** <1–2 lines>
**Owner:** JC
**Started:** YYYY-MM-DD
**Last Updated:** YYYY-MM-DD

## Gameplan (Milestones)
- Phase 1 — <Title>
- Phase 2 — <Title>
- Phase 3 — <Title>

## Current Phase
- Status: 🟡 In progress — <short note>
- Next milestone: <one-liner>

## Summary (keep short)
- <top-level highlights, bullet list>
````

### 4.2 `ticket-progress.md` (working log)

Required sections:

```markdown
# Ticket Progress — <TKT-ID>: <Short Title>
**Goal:** <one-liner>
**Project Link:** @../progress/project-progress.md
**Owner:** JC
**Created:** YYYY-MM-DD
**Status:** 🟡 In progress

## Gameplan
### Phase 1 — <name>
- [ ] Step A
- [ ] Step B
### Phase 2 — <name>
- [ ] Step C

## Progress Log (last 3–5)
| Date       | Phase | Summary                           |
|------------|------:|-----------------------------------|
| YYYY-MM-DD |     2 | <short one-liner>                 |

## Next
- <ordered next steps>

## Notes
- <freeform>
```

> **Progress Agent rules**
>
> * Append to **Progress Log** as table rows.
> * When a phase completes, mark relevant checkbox items and update **Current Phase** in `project-progress.md`.
> * Keep `Progress Log` short (3–5 rows). For older entries, rely on checkpoints or rotation.

---

## 5) Checkpoints & Resume

### 5.1 Checkpoint file format

`.claude/progress/checkpoints/YYYY-MM-DD_HHMMSS.md`

```markdown
# Checkpoint — YYYY-MM-DD HH:MM:SS
**Phase:** <N – Name>
**Summary:** <1–2 line recap>

## Next Steps
- <next-1>
- <next-2>

## WIP Snapshot
- Files: <brief list>
- Intent: <1–2 bullets>

## Note
<optional personal/team note>
```

### 5.2 `RESUME.md` format

```markdown
# Resume Here
Latest checkpoint: @.claude/progress/checkpoints/YYYY-MM-DD_HHMMSS.md

## Quick Resume Steps
1) Read the checkpoint above.
2) Restage local changes if needed.
3) Continue Phase <N> in @.claude/progress/ticket-progress.md.
4) When a meaningful chunk is finished:
   /agents use progress
```

**Handoff Agent**:

* Must always update `RESUME.md` to point to the latest checkpoint.
* May add an optional one-line `[Save]` marker in `ticket-progress.md`.

**Resume Agent**:

* Reads only; prints a summary and **does not** mutate progress files.

---

## 6) Conventional Commits (strict)

Use one of:

* `feat(<area>): <summary> [Phase N]`
* `fix(<area>): <summary> [Phase N]`
* `chore(<area>): <summary> [Phase N]`
* `docs(<area>): <summary> [Phase N]`
* `refactor(<area>): <summary> [Phase N]`
* `test(<area>): <summary> [Phase N]`

Rules:

* `<summary>` ≤ 72 chars; sentence case; no trailing period.
* `<area>` is a path, domain, or capability (e.g., `api`, `router`, `progress`).
* Include `[Phase N]` when tied to a tracked phase.

---

## 7) Router Commands & Modes

* `/agents use progress`

  * If staged changes exist → summarize & write log → suggest commit → print `git` commands.
* `/agents use handoff`

  * Create checkpoint → update `RESUME.md` → optional `[Save]` marker → **no commit**.
* `/agents use resume`

  * Read `RESUME.md` + checkpoint → summarize and list next steps → **no writes**.
* **Alias:** `/commit` → `/agents use progress`

**Sub-modes (meta header the router can parse):**

```
Mode: save            # handoff mode inside progress agent, if supported
Scope: <path|area>    # optional narrowing
```

---

## 8) YAML Front Matter Standard (for agent specs)

Each `CLAUDE.md` begins with valid YAML **only**:

```yaml
---
name: <agent-name>
description: <short single paragraph>
model: sonnet
color: <teal|amber|green|blue|red>
---
```

All examples, commentary, and long text **must** be **below** the YAML.

---

## 9) Rotation Policy (optional)

* Script: `dfwsc_agents/scripts/rotate_progress.sh`
* Behavior: copy `ticket-progress.md` to `progress_archive/ticket_<timestamp>.md` and keep the last **100** lines.
* When: optionally run before creating a checkpoint or weekly via task runner.

---

## 10) Definition of Done (DoD)

A phase is **Done** when:

* All required checkboxes for the phase in `ticket-progress.md` are checked.
* A concise phase completion line has been added to **Progress Log**.
* `project-progress.md` **Current Phase** reflects the new status.
* Relevant code is committed with a conventional message including `[Phase N]`.

A handoff is **Done** when:

* A checkpoint is written.
* `RESUME.md` points to it.
* Optional `[Save]` marker added to `ticket-progress.md`.

---

## 11) Branching & PRs (lightweight)

* Branch: `feature/<ticket-id>-<short-slug>`
* PR title: `<type>(<area>): <summary> [Phase N]`
* PR body includes:

  * What changed
  * Why
  * Checklist:

    * [ ] Updated `ticket-progress.md`
    * [ ] Updated `project-progress.md` (if phase changed)
    * [ ] Added/updated checkpoint (if handoff)

---

## 12) Security & Secrets

* No secrets in commits, checkpoints, or progress files.
* Reference secret names only (e.g., `STRIPE_SECRET`), never values.
* For screenshots or logs: redact tokens, emails, PII.

---

## 13) Agent Output Constraints

* Keep all generated text **concise**:

  * Checkpoints ≤ ~120 lines
  * Progress log entries: single line (table row)
  * Commit summary ≤ 72 chars
* Agents must **not** reformat existing headers/sections.
* Agents must **not** delete prior progress history (rotation handles trimming).

---

## 14) Failure & Retry

* If an agent cannot find expected files, it must:

  1. Print a clear “Missing file” message,
  2. Suggest path to create, and
  3. Exit without side-effects.
* If YAML invalid: do not write; print correction steps.

---

## 15) Quick Start (human checklist)

* [ ] Fill out `project-progress.md` with initial metadata.
* [ ] Start `ticket-progress.md` for your first ticket.
* [ ] Create first checkpoint via `/agents use handoff`.
* [ ] Add router alias `/commit` → `/agents use progress`.
* [ ] (Optional) Enable rotation.

---

**Version:** 1.0 • **Owner:** JC • **Last Updated:** 2025-01-11
