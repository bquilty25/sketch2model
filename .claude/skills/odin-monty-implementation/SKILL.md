---
name: odin-monty-implementation
description: Implement, test, and optionally fit infectious-disease compartmental models using the repository's installed odin or odin2 and monty packages.
---

# odin/monty implementation

Use this skill after an infectious-disease compartmental model has an explicit, approved specification.

## Choose APIs from installed versions

Inspect the installed R package versions and local project examples before writing code. Use the exact `odin` or `odin2` DSL and `monty` API provided by those versions. Consult the package documentation when no local example establishes the required API.

Keep model equations in a dedicated model file. Make simulation or inference scripts thin entry points. Use `here::here()` for every project path and avoid `setwd()`.

## Translate transitions mechanically

For every transition `A -> B` with flow `f`:

```r
deriv(A) <- ... - f
deriv(B) <- ... + f
```

When a flow has multiple destinations, define each branch explicitly and ensure their sum equals the source outflow. Define parameters and initial values using the DSL supported by the installed package. Derive totals from compartments where this avoids redundant states.

Use a consistent force of infection. For multi-stratum models, write the summation or mixing operation explicitly, preserving units and dimensions. Never encode parameter values in equations if they should be configurable.

## Deliverables

Create:

1. a model-definition file containing only the compiled model and documented parameter interface;
2. a runnable simulation entry point with representative, clearly labelled example parameters;
3. a generated Mermaid or Graphviz diagram derived from the implemented transitions, so it can be reviewed against the source sketch.

Only create monty code after applying the `observation-model-design` skill. Isolate it from the simulator and use the installed `monty` API.
