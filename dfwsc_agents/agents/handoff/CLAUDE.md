---
name: handoff
description: Capture a clean, resumable snapshot of the current work-in-progress so any teammate (or your future self) can pick up instantly after a session ends—**without requiring a commit**.
model: qwen3
color: orange
---
# Agent: Handoff / Save Mode

## 🎯 Role
Capture a **clean, resumable snapshot** of the current work-in-progress so any teammate (or your future self) can pick up instantly after a session ends—**without requiring a commit**.

---

## 🧭 When to use
- You’re mid‑phase and need to stop
- You want to park context safely (what’s done, what’s left, where to resume)
- You want a single place to resume next time

Invoke with either:
```
/agents use handoff
```
or (if registered as `progress` sub-mode):
```
/agents use progress
Mode: save
```
Optionally include:
```
Note: <short freeform note to self/team>
```

---

## 📂 Files you read
- @.claude/progress/ticket-progress.md
- @.claude/progress/project-progress.md
- Local git diff (staged first, else HEAD) — only to summarize what changed

## 📝 Files you write
- @.claude/progress/checkpoints/YYYY-MM-DD_HHMMSS.md   ← snapshot
- @.claude/progress/RESUME.md                           ← latest pointer + quick steps
- (optional) append a one‑liner to @.claude/progress/ticket-progress.md marking the save

> Never bloat context: keep snapshots short; do **not** expand archives unless explicitly referenced.

---

## ⚙️ Method
1) **Collect current state**
   - Read *current phase* from `ticket-progress.md`
   - Summarize staged/HEAD changes (files + intent) in one or two bullets
   - Parse unchecked tasks in the current phase → use them as **Next Steps**
   - Include optional `Note:` if provided

2) **Write checkpoint** at `progress/checkpoints/<timestamp>.md` with:
```markdown
# Checkpoint — {{timestamp}}
**Phase:** {{phase}}
**Summary:** {{one-line summary of work so far}}

## Next Steps
- {{next-1}}
- {{next-2}}
- {{next-3}}

## WIP Snapshot
- Files: {{brief file list}}
- Intent: {{1–2 bullet description}}

## Note
{{user note if provided, otherwise omit}}
```

3) **Update RESUME.md** with a pointer + quick resume guide:
```markdown
# Resume Here
Latest checkpoint: @.claude/progress/checkpoints/{{timestamp}}.md

## Quick Resume Steps
1) Read the checkpoint above.
2) Restage local changes if needed.
3) Continue Phase {{phase}} in @.claude/progress/ticket-progress.md.
4) When the next meaningful step completes, run:
   /agents use progress
```

4) **(Optional)** Add a minimal marker to `ticket-progress.md`:
```
| YYYY-MM-DD | {{phase}} | [Save] Snapshot recorded — next: {{next-1}} |
```

> Do **not** modify `project-progress.md` in handoff/save mode unless a phase actually completes.

---

## 🧠 Rules
- No commit is performed in handoff mode.
- Keep all text concise; prefer bullets.
- Trim the ticket log to the last 3–5 entries if it’s getting long.
- Never overwrite—append only. Do not remove existing content automatically.

---

## 🔁 Example

**User:**
```
/agents use handoff
Note: Pausing before curl tests; toggle works e2e in dev
```

**Agent actions:**
- Creates `progress/checkpoints/2025-11-02_1630.md` with the template above
- Updates `progress/RESUME.md` pointer + quick steps
- Appends a one‑line “[Save] …” marker to `ticket-progress.md` (optional)
- Outputs a short confirmation with the written file paths

---

## ✅ Acceptance
- New checkpoint is created with Phase, Summary, Next Steps, WIP Snapshot.
- RESUME.md points to the checkpoint with clear steps.
- Ticket log contains a single‑line “[Save] …” marker (optional).
- No git actions are attempted.