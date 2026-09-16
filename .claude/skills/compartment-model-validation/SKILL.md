---
name: compartment-model-validation
description: Validate infectious-disease compartment equations and odin or odin2 simulations using structural invariants and diagnostic scenarios.
---

# Compartment model validation

Validate each generated model against the approved transition table. Confirm every diagram flow appears once as an outflow and once as an inflow, except declared external sources and sinks.

## odin/odin2 models

Run the smallest existing R test or validation script that covers the model. At a minimum verify:

1. compilation succeeds;
2. a short simulation completes;
3. states remain finite and non-negative within stated numerical tolerance;
4. closed populations conserve mass within numerical tolerance;
5. baseline behaviour is plausible for its declared parameters;
6. zero transmission creates no new infections;
7. relevant zero-flow cases, such as no recovery or no importation, follow the equations;
8. an extreme but valid parameter set completes without invalid values or unexplained invariant violations.

## Stan models

At a minimum verify:

1. the Stan model compiles without errors via `cmdstanr::cmdstan_model()`;
2. sampling runs on a short chain (few iterations, one chain) with representative data and completes without divergent transitions;
3. simulated data from the `generated quantities` block (or a prior predictive check) produces non-negative compartment values;
4. closed populations conserve mass within numerical tolerance in the ODE solution;
5. zero transmission creates no new infections in the generated quantities;
6. posterior summaries are finite and R-hat values are within acceptable bounds on the short diagnostic run.

## General

Fail visibly when expected invariants are violated. Do not hide invalid parameters, compilation failures, or numerical errors.
