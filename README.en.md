[中文](./README.md)

# VibeSkills

> 🐙 An AI capability stack that brings upstream projects, hundreds of skills, MCP entry points, plugin surfaces, and governance rules into one runtime.

`VibeSkills` is the public-facing name of the project, while `VCO` is the governed runtime behind it. This is not a single-purpose tool, and it is not just a skill bundle that happens to patch code. It is an already integrated and governed capability system: `340` directly callable skills, `19` absorbed upstream projects and practice sources, and `129` config-backed policies, contracts, and rules that pull skills, MCP, plugins, workflows, and verification into one governable runtime.
&nbsp;
> [!IMPORTANT]
> **The core vision of Vibe-Skills**: eliminate the cognitive anxiety and high learning cost that come with new technology. Whether or not you have a deep programming background, the goal here is to give you a very low-friction way to access and use today's most advanced AI capability stack, so more people can benefit from the productivity leap AI makes possible.

<div align="center">
  <img src="./logo.png" width="300px" alt="VibeSkills logo">
</div>
&nbsp;
<p align="center">
  <sub>🧠 Planning · 🛠️ Engineering · 🤖 AI · 🔬 Research · 🧬 Life Sciences · 🎨 Visualization · 🎬 Media</sub>
</p>

&nbsp;
&nbsp;

## ✦ What This Repository Can Help You Do From Day One

If you look at these `340` skills through the lens of real work rather than repository folders, `VibeSkills` already covers a full working chain: requirement understanding, solution design, implementation, testing, documentation, data analysis, research support, life-science toolchains, and media generation. The table below is a quick-scan capability map.
&nbsp;
&nbsp;
<small><small><small><small><small>

| Capability Area | What It Covers | Representative Capabilities |
| --- | --- | --- |
| Requirement discovery and problem framing | Turn vague ideas into bounded, testable problem definitions | brainstorming, create-plan, speckit-clarify, aios-analyst, aios-pm |
| Product planning and task breakdown | Turn ideas into specs, plans, tasks, milestones, and execution order | writing-plans, speckit-specify, speckit-plan, speckit-tasks, aios-po, aios-sm |
| Architecture design and technical choice | Design frontend, backend, APIs, data layers, deployment layers, and technical routes | aios-architect, architecture-patterns, context-fundamentals, aios-master |
| Software engineering and code implementation | Build features, scaffold systems, integrate engineering workflows, and land cross-file work | aios-dev, autonomous-builder, speckit-implement |
| Debugging, repair, and refactoring | Diagnose failures, find root causes, repair broken behavior, and restore maintainability | error-resolver, debugging-strategies, systematic-debugging, deslop |
| Testing and quality assurance | Unit tests, regression checks, quality gates, and pre-completion verification | tdd-guide, aios-qa, code-review, verification-before-completion |
| GitHub and release collaboration | Issue / PR handling, CI repair, review comments, deployment, and release workflows | aios-devops, gh-fix-ci, github_*, workflow_*, vercel-deploy |
| Governed workflows and multi-agent collaboration | Freeze requirements, orchestrate stages, assign work, retain proof, and run cleanup | vibe, swarm_*, task_*, agent_*, hive-mind-advanced |
| Skill activation and capability routing | Pull the right skill, MCP surface, plugin, or rule into the right stage | vibe, deepagent-toolchain-plan, hooks_route, semantic-router |
| MCP and external system integration | Browsers, scraping, design files, third-party services, and external context intake | mcp-integration, playwright, scrapling, figma |
| Documentation and knowledge capture | READMEs, technical docs, manuals, diagrams, knowledge notes, and reports | docs-write, docs-review, markdown-mermaid-writing, knowledge-steward |
| Office documents and file workflows | Word, PDF, Excel, CSV, comment replies, and formatting retention | docx, pdf, xlsx, spreadsheet, markitdown |
| Data analysis and statistical modeling | EDA, regression, hypothesis testing, visualization, cleaning, and reporting | statistical-analysis, statsmodels, scikit-learn, polars, dask |
| Machine learning and AI engineering | Data preparation, training, evaluation, explainability, retrieval, and experiment tracking | senior-ml-engineer, training-machine-learning-models, shap, embedding-strategies |
| Visualization and presentation | Charts, interactive visualization, scientific figures, slides, and web showcases | plotly, matplotlib, seaborn, datavis, scientific-slides |
| Research search and academic writing | Literature search, review work, citation management, paper drafting, and submission support | research-lookup, literature-review, citation-management, scientific-writing |
| Life sciences and biomedicine | Bioinformatics, single-cell workflows, proteins, drug discovery, databases, and lab platforms | biopython, scanpy, scvi-tools, alphafold-database, drugbank-database |
| Mathematics, optimization, and scientific computing | Symbolic derivation, Bayesian modeling, multi-objective optimization, simulation, and quantum work | math-tools, sympy, pymc-bayesian-modeling, pymoo, qiskit |
| Images, audio, video, and media production | Image, speech, subtitle, video, and multimedia asset generation | generate-image, imagegen, speech, transcribe, video-studio |

</small></small></small></small></small>

&nbsp;
&nbsp;
## 🧭 If You Break These Capabilities Down Further
&nbsp;
The top-level table is for quick scanning. The sections below make it easier to see that this repository is not just a pile of skills, but a full working surface made of interconnected parts.
&nbsp;
<small><small><small><small>
### 🧩 Planning, Architecture, And Engineering Delivery

- **Requirement discovery and problem framing**: covers interviews, problem definition, boundary discovery, constraint collection, success criteria, and risk anticipation. The point is not to let AI sprint immediately, but to make the task clear first.
- **Product planning and task breakdown**: covers specs, plans, tasks, milestones, dependencies, priorities, and delivery order, so larger ideas can be arranged, tracked, and delivered incrementally.
- **Architecture design and technical choice**: covers frontend structure, backend boundaries, API design, data layers, deployment layers, pattern choice, and technical comparisons, pushing rework and structural drift to the front instead of the end.
- **Software engineering and code implementation**: covers feature work, scaffolding, cross-file modifications, module integration, engineering delivery, and automation, so plans actually become runnable code.
- **Debugging, repair, and refactoring**: covers error localization, root-cause analysis, behavior repair, slop removal, structural refactoring, and maintainability recovery, not just surface-level fixes.
- **Testing and quality assurance**: covers unit tests, property-based checks, regression verification, acceptance checks, quality gates, and completion validation, upgrading "it runs" into "there is evidence it did not break."
- **Code review and engineering standards**: covers review, risk checks, maintainability evaluation, security review, performance guidance, and change recommendations, pushing code from merely usable toward sustainably maintainable.
&nbsp;

### 🔗 Collaboration Governance, Routing, And External Capability Integration

- **GitHub, repository collaboration, and release workflows**: covers issues, PRs, CI repair, review-comment handling, release branches, deployment records, and go-live actions, so delivery does not stop at the local worktree.
- **Governed workflows and multi-agent collaboration**: covers requirement freeze, staged execution, task assignment, proof, cleanup, and multi-agent coordination, so complex work happens inside a governed framework rather than inside a black box.
- **Skill activation and capability routing**: covers rule-based routing, semantic routing, stage triggers, capability orchestration, and dormant-skill wake-up, solving the problem that a repository can have many capabilities that still fail to activate in real tasks.
- **MCP and external system integration**: covers browser automation, web extraction, design-to-code, third-party service connection, plugin entry points, and external context intake, pulling scattered tools into one runtime.
- **Documentation and knowledge capture**: covers READMEs, technical notes, manuals, standard docs, Mermaid diagrams, knowledge entries, and reports, so outcomes remain usable by the team instead of disappearing into chat logs.
- **Office documents and file workflows**: covers Word, PDF, Excel, CSV, Markdown conversion, comment replies, formatting retention, and material organization, filling in a very high-frequency layer of real work.
&nbsp;

### 🔬 Data, AI, Research, And Specialized Domains

- **Data analysis and statistical modeling**: covers EDA, regression analysis, hypothesis testing, metric systems, cleaning and transformation, distribution analysis, and reporting, turning raw data into interpretable conclusions.
- **Machine learning and AI engineering**: covers model training, evaluation, feature work, explainability, embeddings, RAG, experiment tracking, and workflow standardization. This is not just "can train models"; it is a complete AI engineering loop.
- **Research search and academic writing**: covers literature search, review organization, citation management, paper writing, submission preparation, reviewer response, and academic standards, emphasizing workflow completeness rather than isolated tools.
- **Life sciences and biomedicine**: covers bioinformatics, single-cell analysis, protein structure, drug discovery, clinical-trial data, scientific databases, and lab-platform integration. This is one of the most distinctive strength areas in the repository.
- **Mathematics, optimization, and scientific computing**: covers symbolic derivation, Bayesian modeling, multi-objective optimization, simulation, quantum computation, and scientific modeling, suitable for work that requires exact reasoning and complex modeling.
&nbsp;

### 🎨 Visualization, Presentation, And Content Production

- **Visualization and presentation**: covers chart generation, interactive visualization, scientific figures, presentations, web showcases, and information design, turning results into readable and shareable artifacts.
- **Images, audio, video, and media production**: covers image generation, infographics, speech synthesis, subtitle generation, video production, and multimedia organization, supporting the full path from static visuals to richer media output.
</small></small></small></small>
&nbsp;
&nbsp;

If you connect these parts together, the repository really covers a complete working flow: understand the request, create the plan, choose the architecture, implement, verify, collaborate, publish, and then extend into documentation, data analysis, AI engineering, research writing, life sciences, and media expression. That breadth is exactly why governance and standardization matter here, instead of relying only on a high skill count.

The clearest differentiators remain AI engineering, research writing, and life sciences. Many repositories mention machine learning or research support, but often only as scattered tool fragments. The difference here is that these areas are already organized into upstream-downstream workflow chains rather than isolated capability points.

&nbsp;
&nbsp;

## 📦 What Resources Have Already Been Integrated


This repository is not trying to reinvent everything from scratch. It keeps absorbing structures, methods, and workflows that strong upstream projects have already made useful in practice, then brings them under one governed system.

<small><small><small><small>

| Resource Type | Current Depth | Why It Matters |
| --- | --- | --- |
| Skills and capability modules | 340 directly callable skills / capability modules | Cover the full work chain from requirement discovery, planning, coding, and verification to documentation, data, research, and media generation |
| MCP / plugin / browser entry points | Multiple external-tool access surfaces | Bring outside services, web pages, design assets, retrieved results, and automation flows into one runtime |
| Upstream projects and practice sources | 19 high-value projects and practice sources | Absorb the strengths of mature projects into one system instead of forcing users to assemble everything manually |
| Governance rules and contracts | 129 config-backed policies, contracts, and rules | Constrain clarification, planning, execution, verification, traceability, cleanup, and rollback so the system remains maintainable over time |

</small></small></small></small>

**The project continuously integrates and governs strengths from superpower, claude-scientific-skills, get-shit-done, aios-core, OpenSpec, ralph-claude-code, and SuperClaude_Framework, pulling their advantages in prompt organization, skill accumulation, plan-driven execution, governed workflows, scientific support, and engineering collaboration into one unified system. Deep thanks to the authors of those repositories; without their generous work, Vibe-Skills would not exist.**

That is one of the core differences between VibeSkills and an ordinary prompt collection or skill-index repository: what you see here is not a static list, but an already integrated capability network that can be routed, governed, and verified.

&nbsp;
&nbsp;

## ✨ Why It Feels Different Right Away

Many skill repositories are only trying to answer one question: what capabilities exist here?

**VibeSkills cares more about a different set of questions:**

- **What should be called now, instead of making you manually search the entire skill list**
- **What should happen first, instead of letting AI jump straight into execution**
- **Which capabilities can be safely combined, and where explicit boundaries are required**
- **How the result gets verified, recorded, and protected from long-term black-box drift**

It is not trying to pile up more capabilities.
It is trying to turn calling, governance, verification, and review into one system that actually works.

&nbsp;
&nbsp;

## ⚠️ The Real Pain Points It Solves

If you already use AI heavily, you have probably run into problems like these:

- **Too many skills, with no clear answer for which one fits the current task**
- **Low skill activation rates, where the repo clearly contains many capabilities but real tasks still fail to trigger them, remember them, or connect them into the workflow**
- **Projects, plugins, and workflows overlapping and conflicting with each other**
- **AI jumping into execution before the requirement is actually clarified**
- **No verification, no proof, and no rollback surface after the work is done**
- **As usage deepens, the overall workflow starts feeling like a black box no one can fully explain**

VibeSkills does not pretend these problems are imaginary.
Its value is that it faces them directly.

The VCO ecosystem is also trying to solve a very practical problem: the issue is not that there are too few skills, but that too many of them stay dormant and their real activation rate stays low. Through routing decisions, MCP and plugin entry points, workflow orchestration, and governance rules, the system tries to pull the right capability into the right stage at the right time, instead of leaving it asleep in the repository.

&nbsp;
&nbsp;

## ⚙️ How It Works

You can think about it as three layers:

### 1. 🧠 Smart Routing

In the right scenario, you should not have to explicitly remember which skill to call every time.

VibeSkills combines logical routing and AI-assisted routing so the right capability can enter the right context more naturally, instead of forcing you to memorize the entire skill list. One of the things the VCO ecosystem is trying to fix is low skill activation, so more capabilities can actually enter execution in the correct stage and context.

### 2. 🧭 Governed Workflows

This system is not only about "calling tools."
It is more concerned with how the work gets done in a stable way.

That is why it tries to bring requirement clarification, confirmation, execution, verification, review, and traceability into one consistent flow, instead of letting AI run as a black box from the beginning.

### 3. 🧩 Integrated Capabilities

This is not just a pile of skills.

It also includes plugins, projects, workflow design, AI norms, safety boundaries, long-term maintenance experience, and the mistakes I have already learned from in practice. VCO is what keeps those capabilities organized as one runtime instead of leaving them scattered everywhere.

## 👥 Who It Is For

VibeSkills is mainly for:

- ordinary users who want AI to help them more reliably
- advanced users who already work heavily with AI / agents / automation
- individuals or small teams who want more standardized and maintainable AI workflows
- people who are tired of an ecosystem that has too many skills but still feels hard to use

If you only want a single-purpose tool, this repository may be heavier than what you need.
If you want to use AI in a steadier, smoother, and more durable way, it becomes much more meaningful.

&nbsp;
&nbsp;

## 🚀 Start Here

One key point first: to preserve broad cross-agent compatibility, this is not a traditional standalone app repository. It is a **skills-format project**, so the normal way to use it is to invoke it through the host environment's skill syntax rather than treating it like a regular CLI program.

- In Claude Code, use `/vibe`
- In Codex, use `$vibe`


If you are ready to install, the one-click installation entry is here:

- [`docs/install/one-click-install-release-copy.en.md`](./docs/install/one-click-install-release-copy.en.md)



If you want a quick way to understand the system first and then decide how deep to go:

- [`docs/quick-start.en.md`](./docs/quick-start.en.md)
- [`docs/manifesto.en.md`](./docs/manifesto.en.md)

If you are already a heavy user and want fuller installation and path details:

- [`docs/install/recommended-full-path.en.md`](./docs/install/recommended-full-path.en.md)
- [`docs/cold-start-install-paths.en.md`](./docs/cold-start-install-paths.en.md)

&nbsp;
&nbsp;

## 📐 Project Philosophy

The core idea of VibeSkills is standardization. Only when requirement clarification, task planning, execution, verification, traceability, and rollback are turned into reusable order can human intent become clearer, AI execution become steadier, and long-term maintenance keep technical debt under control.

This project is not trying to make AI look more magical. It is trying to let users focus on expressing the goal, while the remaining work gets continuously implemented, verified, and maintained inside a standardized workflow, turning the most failure-prone part of real AI work into something more callable, more governable, and more maintainable over time.
