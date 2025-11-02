Here’s a breakdown of the recommendations and why each one matters:

1. **Fix the YAML front matter in `context-synthesis.md`**
   The first section of each agent file uses YAML to define metadata like `name`, `description`, and `model`. In `context-synthesis.md` the description contains unescaped colons within the examples, causing the YAML parser to throw an error. Cleaning up the YAML (escaping problematic characters or moving examples outside the front matter) will allow the file to load properly. Removing the stray “h” at the end of the file is simply good housekeeping.

2. **Align the naming of sub-agents**
   The context-synthesis prompt references two sub‑agents—**File Location Researcher** and **Implementation Logic Researcher**—but the repository actually provides `codebase-locator.md` and `codebase-analyzer.md`. If those are meant to be the same, renaming them consistently across all files will prevent confusion and ensure the parent agent calls the correct agents.

3. **Clarify how outputs are stored and passed along**
   Each agent describes what it should analyze, but none explain how to structure or persist the results. For a parent-agent workflow, you need a way to collect outputs from one agent and feed them into the next (for example, as JSON or structured text). Explicit instructions on how each agent should return its findings help maintain continuity.

4. **Broaden the anti‑pattern sniffer’s scope if needed**
   The `antipattern-sniffer.md` explicitly targets newly written code. If you intend to scan an existing codebase for anti‑patterns, its instructions should be updated to allow that. Otherwise, the agent may skip important legacy issues.

5. **Test the workflow end‑to‑end**
   Once the above adjustments are made, run through the workflow as if you are the parent agent: locate relevant files, analyze them, sniff for anti‑patterns, detect dead code, and synthesize the results. This will surface any additional gaps or mismatches in the prompts and ensure that the instructions interoperate smoothly.

These steps are designed to make the prompts more robust and cohesive so that you, acting as the parent agent, can orchestrate the sub‑agents effectively.
