# sketch2model

An AI agent that converts hand-drawn compartmental model sketches or mathematical equations into validated, reproducible simulation and inference code. The agent reads images through LLM vision, critiques model specifications, writes and tests code, and interacts with the user to resolve ambiguities, all within a single conversational session. It produces `odin`/`odin2` with `monty`, or Stan with `cmdstanr` code. The approach applies to any system describable by ordinary differential equations, difference equations, or compartmental flows, with infectious disease transmission models as the primary application domain.

## How it works

The agent autonomously sequences through an eight-stage workflow, loading the relevant skill at each stage and pausing only to ask the user for clarification or approval at defined decision points:

1. **Project setup** -- establish or inspect the R project structure
2. **Sketch specification** -- extract compartments, transitions, and rates from a photographed diagram into a confidence-rated transition table using LLM vision (no external OCR)
3. **Equation specification** -- extract the model from mathematical equations (LaTeX, handwritten, or typed), as an alternative to or cross-referenced with a sketch
4. **Model critique** -- audit for blocking issues (undefined flows, unit mismatches, mass balance), modelling concerns, and optional extensions
5. **Implementation** -- translate the approved specification into `odin`/`odin2` DSL code or a Stan model, with a runnable simulation and generated diagram
6. **Observation model design** -- design the likelihood/observation layer when data is provided, mapping data series to model outputs
7. **Validation** -- verify compilation, non-negativity, mass conservation, zero-transmission behaviour, and extreme-parameter scenarios
8. **Traceability** -- save an audit trail linking the source input, transcription, decisions, code, diagram, and validation results

The agent asks focused questions at each stage and never silently adds mechanisms absent from the source input.

## Usage

Attach a photo of a hand-drawn compartmental model diagram, provide mathematical equations, or both, and let the agent convert them to code.

### Claude Code (primary)

The `sketch2model` agent is defined in `.claude/agents/sketch2model.md`. Skill definitions for each pipeline stage are in `.claude/skills/`.

```bash
cd sketch2model
claude
# invoke the agent, then attach your sketch image or paste equations
```

### GitHub Copilot

To use with Copilot Chat in VS Code:

1. Copy `.claude/skills/` to `.github/skills/` (Copilot's expected layout).
2. Create `.github/agents/sketch2model.agent.md` with frontmatter targeting `github-copilot`, referencing the skills in order. Use the workflow and output requirements from `.claude/agents/sketch2model.md` as the agent body.

### Other LLM agent harnesses

The core instructions live in two places:

- **`.claude/agents/sketch2model.md`** -- the full agent prompt: persona, workflow steps, and output constraints. Copy or adapt this as your agent's system prompt.
- **`.claude/skills/*/SKILL.md`** -- eight self-contained skill documents, one per pipeline stage. Each is plain Markdown with a YAML frontmatter header (`name`, `description`). Feed them to your agent as context at the relevant stage, or concatenate them all into a single prompt.

Any harness that supports multimodal input (image attachments) and structured prompting can run this pipeline. The key requirement is that the model uses its own vision capabilities to read the input, not an external OCR tool.

## Requirements

- R with `tidyverse`, `here`, `qs`, and `odin` or `odin2` installed
- `monty` for odin-based inference workflows
- `cmdstanr` and CmdStan for Stan-based models
- `testthat` for validation tests

## Project structure

When a model is generated, the pipeline creates:

```
data/raw/           # source data (never modified)
data/processed/     # intermediate objects saved with qs
scripts/            # numbered analysis scripts
scripts/functions/  # reusable helper functions
models/             # odin/odin2 or Stan model definitions
outputs/            # plots, tables, diagrams
tests/testthat/     # validation tests
```
