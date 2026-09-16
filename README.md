# sketch2model

Converts hand-drawn infectious disease compartmental model sketches into validated, reproducible R code using `odin`/`odin2` and `monty`.

## How it works

A Copilot agent (`sketch-to-odin`) orchestrates a seven-step pipeline:

1. **Project setup** -- establish or inspect the R project structure
2. **Sketch specification** -- extract compartments, transitions, and rates from a photographed diagram into a confidence-rated transition table
3. **Model critique** -- audit for blocking issues (undefined flows, unit mismatches, mass balance), modelling concerns, and optional extensions
4. **odin/monty implementation** -- translate the approved specification into `odin`/`odin2` DSL code with a runnable simulation and generated diagram
5. **Observation model design** -- design the likelihood/observation layer when data is provided, mapping data series to model outputs
6. **Validation** -- verify compilation, non-negativity, mass conservation, zero-transmission behaviour, and extreme-parameter scenarios
7. **Traceability** -- save an audit trail linking the source sketch, transcription, decisions, code, diagram, and validation results

The agent asks focused questions at each stage and never silently adds mechanisms absent from the sketch.

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
