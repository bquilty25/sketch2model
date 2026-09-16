# sketch2model

Converts hand-drawn infectious disease compartmental model sketches into validated, reproducible R code using `odin`/`odin2` and `monty`.

## Agent

The `sketch2model` agent is defined in `.claude/agents/sketch2model.md`. Invoke it with `/agents sketch2model` or by starting a session that references it. Skill definitions for each pipeline stage are in `.claude/skills/`.

## Project structure

```
data/raw/           # source data (never modified)
data/processed/     # intermediate objects saved with qs
scripts/            # numbered analysis scripts
scripts/functions/  # reusable helper functions
models/             # odin/odin2 model definitions
outputs/            # plots, tables, diagrams
tests/testthat/     # validation tests
```

## Conventions

- All paths use `here::here()`, never bare relative strings or `setwd()`.
- `data/raw/` is in `.gitignore`. Never commit patient-identifiable or sensitive data.
- `snake_case` names, native R pipe `|>`, UK English in prose.
- Image interpretation uses LLM vision only, never external OCR.
