# sketch2model

Converts hand-drawn infectious disease compartmental model sketches into validated, reproducible R code using `odin`/`odin2` and `monty`.

## How it works

An AI agent orchestrates a seven-step pipeline:

1. **Project setup** -- establish or inspect the R project structure
2. **Sketch specification** -- extract compartments, transitions, and rates from a photographed diagram into a confidence-rated transition table using LLM vision (no external OCR)
3. **Model critique** -- audit for blocking issues (undefined flows, unit mismatches, mass balance), modelling concerns, and optional extensions
4. **odin/monty implementation** -- translate the approved specification into `odin`/`odin2` DSL code with a runnable simulation and generated diagram
5. **Observation model design** -- design the likelihood/observation layer when data is provided, mapping data series to model outputs
6. **Validation** -- verify compilation, non-negativity, mass conservation, zero-transmission behaviour, and extreme-parameter scenarios
7. **Traceability** -- save an audit trail linking the source sketch, transcription, decisions, code, diagram, and validation results

The agent asks focused questions at each stage and never silently adds mechanisms absent from the sketch.

## Usage

Attach a photo of a hand-drawn compartmental model diagram and let the agent convert it to code.

### Claude Code (primary)

The `sketch2model` agent is defined in `.claude/agents/sketch2model.md`. Project-level context is in `CLAUDE.md`. Skill definitions for each pipeline stage are in `.claude/skills/`.

```bash
cd sketch2model
claude
# invoke the agent, then attach your sketch image
```

### GitHub Copilot

To use with Copilot Chat in VS Code:

1. Copy `.claude/skills/` to `.github/skills/` (Copilot's expected layout).
2. Create `.github/agents/sketch2model.agent.md` with frontmatter targeting `github-copilot`, referencing the skills in order. Use the workflow and output requirements from `.claude/agents/sketch2model.md` as the agent body.

### Other LLM agent harnesses

The core instructions live in two places:

- **`.claude/agents/sketch2model.md`** -- the full agent prompt: persona, workflow steps, and output constraints. Copy or adapt this as your agent's system prompt.
- **`.claude/skills/*/SKILL.md`** -- seven self-contained skill documents, one per pipeline stage. Each is plain Markdown with a YAML frontmatter header (`name`, `description`). Feed them to your agent as context at the relevant stage, or concatenate them all into a single prompt.

Any harness that supports multimodal input (image attachments) and structured prompting can run this pipeline. The key requirement is that the model uses its own vision capabilities to read the sketch, not an external OCR tool.

## Requirements

- R with `tidyverse`, `here`, `qs`, and `odin` or `odin2` installed
- `monty` for inference workflows
- `testthat` for validation tests

## Project structure

When a model is generated, the pipeline creates:

```
data/raw/           # source data (never modified)
data/processed/     # intermediate objects saved with qs
scripts/            # numbered analysis scripts
scripts/functions/  # reusable helper functions
models/             # odin/odin2 model definitions
outputs/            # plots, tables, diagrams
tests/testthat/     # validation tests
```
