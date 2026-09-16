---
name: odin-monty-implementation
description: Implement, test, and optionally fit infectious-disease compartmental models using odin/odin2 with monty, or Stan with cmdstanr.
---

# Model implementation

Use this skill after an infectious-disease compartmental model has an explicit, approved specification.

## Choose the implementation target

The default target is `odin` or `odin2` with `monty` for inference. Use Stan with `cmdstanr` when:

- the user explicitly requests Stan;
- the model requires features native to Stan, such as hierarchical priors, non-centred parameterisations, or custom probability distributions not available in monty;
- the user's existing project already uses Stan.

When the choice is unclear, ask the user.

## odin/odin2 path

### Choose APIs from installed versions

Inspect the installed R package versions and local project examples before writing code. Use the exact `odin` or `odin2` DSL and `monty` API provided by those versions. Consult the package documentation when no local example establishes the required API.

Keep model equations in a dedicated model file. Make simulation or inference scripts thin entry points. Use `here::here()` for every project path and avoid `setwd()`.

### Translate transitions mechanically

For every transition `A -> B` with flow `f`:

```r
deriv(A) <- ... - f
deriv(B) <- ... + f
```

When a flow has multiple destinations, define each branch explicitly and ensure their sum equals the source outflow. Define parameters and initial values using the DSL supported by the installed package. Derive totals from compartments where this avoids redundant states.

Use a consistent force of infection. For multi-stratum models, write the summation or mixing operation explicitly, preserving units and dimensions. Never encode parameter values in equations if they should be configurable.

### odin deliverables

Create:

1. a model-definition file containing only the compiled model and documented parameter interface;
2. a runnable simulation entry point with representative, clearly labelled example parameters;
3. a generated Mermaid or Graphviz diagram derived from the implemented transitions, so it can be reviewed against the source input.

Only create monty code after applying the `observation-model-design` skill. Isolate it from the simulator and use the installed `monty` API.

## Stan path

### Stan model file

Write a `.stan` file in `models/` with clearly separated `functions`, `data`, `transformed data`, `parameters`, `transformed parameters`, `model`, and `generated quantities` blocks. Encode the ODE system in the `functions` block using Stan's ODE solver interface (`ode_rk45`, `ode_bdf`, or `ode_adjoint` as appropriate for stiffness).

Keep the Stan file self-contained. Document parameters, data expectations, and priors with comments in the file header.

### cmdstanr fitting script

Provide a thin R script that:

1. loads data and prepares the Stan data list;
2. compiles the model with `cmdstanr::cmdstan_model()`;
3. runs sampling, optimisation, or variational inference as requested;
4. extracts and summarises posterior draws.

Use `here::here()` for all paths. Do not hard-code data values in the Stan file when they should be passed as data.

### Stan deliverables

Create:

1. a `.stan` model file in `models/`;
2. a runnable R fitting or simulation script;
3. a generated Mermaid or Graphviz diagram derived from the implemented transitions.

Only include a likelihood and priors in the Stan model after applying the `observation-model-design` skill.
