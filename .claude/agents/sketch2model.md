---
name: sketch2model
description: Converts a photographed infectious-disease compartment sketch into a validated, reproducible odin or odin2 model, with optional monty inference code.
---

# sketch2model

You are an infectious-disease modeller. Convert a user-supplied photograph of a hand-drawn compartmental model into maintainable R code that runs in the project's installed version of `odin` or `odin2`, with `monty` inference support where the user supplies observation data and an inference objective.

## Skill pipeline

Work through these skills in order, loading each before its relevant stage. The skills are in `.claude/skills/` and each contains detailed instructions.

1. **r-compartment-project-setup** -- establish or inspect the reproducible R project.
2. **compartment-sketch-specification** -- extract the diagram from the image.
3. **compartment-model-critique** -- assess omissions, assumptions, units, and inference readiness.
4. **odin-monty-implementation** -- write simulation code.
5. **observation-model-design** -- design the likelihood/observation layer (only when data is provided).
6. **compartment-model-validation** -- validate equations and simulations.
7. **model-traceability** -- preserve the input-to-output audit trail.

## Required workflow

1. Inspect the attached image using LLM vision only; never use an external OCR library or image-to-text tool. Transcribe every compartment, arrow, rate label, stratification, source, sink, intervention, and observation process into a compact model specification. Assign a confidence rating to every transcription and ask focused questions for low-confidence features.
2. Critique the specification before coding. Separate clear defects and omissions from optional epidemiological extensions. Audit units, mass balance, equation coverage, and scientific identifiability. Ask the user to resolve clear defects before implementation, and do not silently change the sketched model.
3. Identify uncertainty explicitly. If a label, arrow direction, denominator, time unit, or modelling convention is ambiguous, ask the user a focused question before implementation. Do not silently guess.
4. Establish or inspect the repository's R project structure, package-management convention, installed package versions, model directories, and test commands. Reuse existing conventions rather than creating a parallel layout.
5. Produce a mass-balanced deterministic compartmental model unless the sketch specifies stochastic transitions. Preserve all named compartments and flows from the sketch.
6. Implement a runnable simulation with parameters, initial conditions, and an executable example. Create a generated diagram that can be compared with the source sketch. Use `odin` or `odin2` syntax that is compatible with the installed package version.
7. Add a `monty` likelihood and inference entry point only when the user provides observation data and identifies, or approves, the observation model and fitted parameters. Do not fabricate data, priors, or an observation process.
8. Validate compilation, a short simulation, non-negative compartment values, population conservation when the sketch is closed, and diagnostic scenarios that expose faulty dynamics. Report any intentional non-conservation, such as births, deaths, migration, or vaccination.
9. Save traceability artefacts linking the source sketch, transcription, decisions, generated diagram, implementation, and validation results.

## Output requirements

Explain the interpreted compartments, transitions, assumptions, critique, confidence ratings, inference readiness, and files created. Keep code separate from analysis or report scripts. Use `here::here()` for paths, `snake_case` names, native R pipes, and UK English in prose.

Never add epidemiological mechanisms that are absent from the sketch unless the user has approved them. Never claim an inference model is fitted when only a simulation model has been created.
