# DFWSC Human Layer  
*Prompt / workflow pack for codebase exploration, audit & onboarding*  
**DFW Software Consulting (DFWSC)**  

## Why this exists  
Large or legacy code-bases often become opaque over time: missing documentation, unknown dependencies, hidden anti-patterns, dead code, and general technical debt.  
This “Human Layer” toolkit is designed to help your team (or an AI-assistant + human combo) **cut through the fog** and surface actionable insights:

- Quickly locate relevant modules/files for a task  
- Analyze architecture, module relationships and dependencies  
- Identify anti-patterns and detect dead/stale code  
- Synthesize findings into prioritized issues or tickets  

In other words: it’s your *code-base X-ray toolkit* — combining structured prompts with workflows to turn chaos into clarity.

## What’s included  
Each markdown file corresponds to one phase of the workflow:

| File | Purpose |
|------|---------|
| `codebase-locator.md`     | Guide for locating the pertinent parts of the repo (modules, services, features) |
| `codebase-analyzer.md`    | Dive into structure, dependencies, hotspots, architecture |
| `antipattern-sniffer.md`  | Detect code smells, anti-patterns, architectural mistakes |
| `dead-code-detector.md`   | Identify unused, obsolete, or redundant code paths |
| `context-synthesis.md`    | Take findings from all phases and turn them into an **action plan** (issues, backlog, next steps) |

## Who should use this  
This toolkit is ideal for:

- New team-members onboarding into an existing code-base  
- Refactoring efforts, technical-debt sprints or “cleanup” windows  
- Audit/health-checks of third-party code or legacy systems  
- Developers, architects or consultants working with teams where codebase clarity is needed  
- Mentoring junior developers: walk them through structured analysis rather than ad-hoc exploration  

## How to use  
1. **Select your target repo or code-base** you want to apply this workflow to.  
2. Start with `codebase-locator.md`: run through the prompts, document the relevant files/modules.  
3. Move to `codebase-analyzer.md`: understand architecture, key flows, dependencies, state of the system.  
4. Use `antipattern-sniffer.md` and `dead-code-detector.md` to identify areas needing cleanup, refactoring or removal.  
5. Finalize with `context-synthesis.md`: build a prioritized **issue backlog** (title, description, acceptance criteria, priority) ready for your project board or sprint planning.  
6. Assign tickets, establish owners, track progress — and re-run the workflow periodically (e.g., at major version releases or every 6-12 months) to maintain codebase health.

## Best practices & tips  
- **Document as you go**: Use the prompts to build a living document rather than just checkboxes.  
- **Version the analysis**: For major changes (new architecture, large refactor) run the workflow fresh so you have a historical “snapshot”.  
- **Share results with the team**: Present the findings in a team meeting or onboarding session to build common understanding.  
- **Automate when possible**: While this is a human-friendly toolkit, you can hook in static-analysis tools or linters to support the anti-pattern and dead-code detection phases.  
- **Iterate the workflow**: Customize the questions/prompts to your team’s stack (e.g., microservices, serverless, mono-repo) — don’t treat the MD files as unchangeable.

## How this helps DFWSC clients & internal teams  
For DFWSC consulting across multiple clients and codebases, this toolkit ensures:  
- A **consistent onboarding framework** for new developers joining a project  
- A **repeatable audit process** for technical-debt sprints or client-deliverables  
- An efficient way to **turn insights into execution-ready tickets** — reducing discovery-to-deliverables time  

## Contributing  
Want to improve the toolkit?  
- Add an additional phase (e.g., “security-audit-scanner.md” or “performance-bottleneck-finder.md”)  
- Update existing prompts for new languages/frameworks  
- Report issues or submit pull requests via the repo’s GitHub Issues tab  
- Maintain alignment with DFWSC’s internal standards and consult-engagement best-practices  

## License & Attribution  
This repository is © 2025 DFW Software Consulting (Dallas, TX).  
You may use and adapt the toolkit internally or for clients, but please retain this header and give attribution back to DFWSC when distributing externally.

---

*Happy exploring & cleaning up codebases!*  
The DFWSC Team  
