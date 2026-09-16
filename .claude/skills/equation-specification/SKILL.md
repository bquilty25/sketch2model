---
name: equation-specification
description: Interpret mathematical equations describing an infectious-disease compartmental model into an explicit, reviewable model specification before coding.
---

# Equation specification

Use this skill whenever a user supplies mathematical equations describing a compartmental model, whether as LaTeX, handwritten formulae in an image, typed plain text, or extracted from a published paper. This skill may be used instead of or alongside `compartment-sketch-specification` when equations are the primary or supplementary input.

## Extract the model faithfully

Use LLM vision to read handwritten or typeset equations directly. Never delegate to an external OCR library, computer-vision model, or image-to-text tool; the language model's own multimodal capabilities are the sole mechanism for reading the input.

Parse and record:

- every state variable and its interpretation (compartment, cumulative counter, auxiliary);
- every ordinary differential equation or difference equation, preserving the exact mathematical form;
- the meaning, units, and dimensions of each parameter;
- the force of infection expression and its functional form (frequency-dependent, density-dependent, or other);
- population strata, indices, age groups, or spatial dimensions;
- external inflows and outflows, including births, natural deaths, and importations;
- initial conditions, whether stated explicitly or implied;
- time units and whether the system is continuous or discrete;
- any observation or measurement model equations supplied alongside the dynamical system.

Represent the extracted system as a transition table identical in format to the one produced by `compartment-sketch-specification`:

| Source | Destination | Flow expression | Parameters | Confidence and notes |
| --- | --- | --- | --- | --- |

For each equation, verify that all terms on the right-hand side correspond to entries in the transition table. Flag any term that does not map to a named flow.

Assign each extracted item a confidence rating:

- **High**: unambiguous notation, clear variable definitions, and consistent dimensions;
- **Medium**: legible but notation is non-standard or variable definitions must be inferred from context;
- **Low**: ambiguous subscripts, unclear summation bounds, undefined symbols, or possible typographical errors.

Never implement a low-confidence equation or parameter interpretation without user confirmation. Include a concise list of medium-confidence assumptions for review.

## Cross-reference with a diagram when both are supplied

When the user provides both equations and a compartmental diagram, cross-reference the two inputs. For each discrepancy, such as a flow present in the diagram but absent from the equations or vice versa, flag it explicitly and ask the user which source takes precedence.

## Resolve ambiguity safely

Do not infer undefined symbols, summation conventions, dimensionality, or whether a term represents a per-capita rate or an absolute flow. Mark these as unresolved.

Ask one focused question when any unresolved point changes the equations. Examples include whether a transmission term uses total population N as a denominator, whether a death rate applies to all compartments or only specific ones, and whether indexed parameters share values or are independently specified.

## Confirm the specification

Before implementation, present the extracted specification in concise prose and the transition table. State:

1. the model time unit;
2. the force-of-infection expression;
3. whether total population is expected to be conserved;
4. all assumptions approved by the user.

Only proceed to code after these points are unambiguous.
