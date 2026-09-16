---
name: r-compartment-project-setup
description: Establish and maintain a reproducible R project foundation for infectious-disease compartment modelling with tidyverse, here, qs, odin or odin2, monty, and testthat.
---

# R compartment project setup

Use this skill first for new modelling work and whenever an existing project needs assessment. Prefer the repository's existing conventions. Do not replace its package-management, testing, or reporting tools unless the user asks.

## Project structure

For a new project, create or retain this layout:

```text
data/raw/
data/processed/
scripts/
scripts/functions/
models/
outputs/
tests/testthat/
```

Create an `.Rproj` file when absent so `here::here()` can locate the project root. Never call `setwd()` and never use absolute paths in R code. Ensure `data/raw/` is ignored by Git where Git is in use, and never modify raw data.

Use numbered files for ordered analysis scripts, such as `scripts/01_simulate_model.R`, and provide `scripts/00_run_pipeline.R` only when multiple scripts form a pipeline. Keep reusable code in `scripts/functions/` or `models/`, not duplicated in analysis scripts.

## Packages and reproducibility

Use R as the implementation language. Use:

- `tidyverse` for tabular data handling, plotting, and functional iteration;
- `here` for all project paths;
- `qs` for processed or computationally expensive R objects;
- `odin` or `odin2`, according to the installed version and project convention;
- `monty` only for approved inference workflows;
- `testthat` for focused automated tests where it is available.

Inspect existing dependency files before adding packages. For a new project, use `renv` when it is installed or when the user requests reproducible dependency locking. Record all direct dependencies in the project's chosen dependency manifest and avoid attaching packages unnecessarily: prefer qualified calls such as `dplyr::mutate()` in reusable functions.

## Code and reporting standards

Use `snake_case`, native pipes (`|>`), vectorised operations, and `purrr::map_*()` where appropriate. Format code according to tidyverse conventions.

Use Quarto for reports when narrative output is requested. Write UK English prose and organise scientific reports using IMRaD: Abstract, Introduction, Methods, Results, Discussion, and a concluding paragraph. Keep results descriptive, reserving interpretation for the Discussion.

Persist processed data with `qs::qsave()` under `data/processed/`, using paths made with `here::here()`. Store plots and tables under `outputs/`.

## Initial checks

Before modelling, report whether R, the selected odin package, `tidyverse`, `here`, `qs`, and any requested inference dependencies are installed. Do not install missing packages without user approval. Run the smallest available project setup or test command after changing project configuration.
