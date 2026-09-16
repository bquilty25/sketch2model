---
name: compartment-model-critique
description: Critique an extracted infectious-disease compartment model for missing mechanisms, incoherent assumptions, unit errors, and inference risks.
---

# Compartment model critique

Apply this skill after diagram extraction and before code generation. Do not alter the model without user approval.

Report three categories:

1. **Blocking issues**: defects that prevent a runnable model, such as undefined flows, missing initial conditions, undefined denominators, incompatible time units, or unexplained population loss.
2. **Important modelling concerns**: omissions or assumptions that may invalidate the stated scientific question, such as incompatible immunity and reinfection, absent competing risks, or an unseeded outbreak.
3. **Optional extensions**: mechanisms that may be useful but are absent from the requested model, such as age structure, seasonality, waning immunity, vaccination, spatial mixing, or reporting.

A standard-model mechanism is not missing merely because it is common. Explain every finding in terms of its impact on mass balance, dynamics, interpretation, or inference. For every blocking issue, propose the smallest resolution and obtain a user decision.

Audit each flow for units of people per model time unit. Verify that rate units are compatible with the declared time unit, transmission terms have correct dimensions, all transitions occur once as an outflow and once as an inflow, and every source or sink is explicit.

If inference is proposed, assess whether each fitted parameter is informed by an observation, confounded with another parameter, or dependent on known population denominators or initial conditions. Do not introduce a likelihood, priors, or reporting assumptions.
