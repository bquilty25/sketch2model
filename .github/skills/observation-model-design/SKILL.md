---
name: observation-model-design
description: Design an explicit, identifiable observation model for fitting infectious-disease compartment models with monty.
---

# Observation model design

Use this skill only when the user wants inference or provides data. Distinguish latent model states from observed quantities.

For every data series, document its time scale, population coverage, units, and mapping to a model output, such as incidence, prevalence, admissions, deaths, or seropositivity. Specify any aggregation period and delay.

Obtain user approval before selecting the observation distribution, fitted parameters, priors, reporting fraction, delay model, dispersion, or measurement-error model. Explain parameter confounding and identify parameters that should be fixed or informed by external evidence.

Only after these choices are explicit may the implementation include monty likelihood code. Keep the likelihood separate from the latent-state model and expose all observation parameters in the documented interface.
