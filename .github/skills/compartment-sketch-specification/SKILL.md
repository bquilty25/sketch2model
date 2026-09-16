---
name: compartment-sketch-specification
description: Interpret a photo of an infectious-disease compartment sketch into an explicit, reviewable model specification before coding.
---

# Compartment sketch specification

Use this skill whenever a user supplies a photographed, scanned, or hand-drawn infectious-disease compartmental diagram.

## Extract the diagram faithfully

Use LLM vision to interpret the image directly. Never delegate to an external OCR library, computer-vision model, or image-to-text tool; the language model's own multimodal capabilities are the sole mechanism for reading the sketch.

Read the image at full available resolution. Record:

- every compartment and its exact label;
- every directed transition, its source, destination, and rate label;
- the meaning and units of each rate or parameter;
- population strata, indices, age groups, locations, or pathogen variants;
- external inflows and outflows, including births, deaths, migration, and importations;
- interventions and time-varying inputs;
- observations, reporting delays, or measurement arrows that are distinct from disease transitions;
- legends, annotations, initial values, and stated time units.

Represent transitions as a table before coding:

| Source | Destination | Flow expression | Parameters | Confidence and notes |
| --- | --- | --- | --- | --- |

For each compartment, list its incoming and outgoing flows. This creates a conservation audit and exposes missing arrow directions.

Assign each extracted item a confidence rating:

- **High**: unambiguous label, direction, and connection;
- **Medium**: legible but contextual interpretation is required;
- **Low**: obscured, unreadable, or potentially connected to multiple elements.

Never implement a low-confidence transition or parameter interpretation without user confirmation. Include a concise list of medium-confidence assumptions for review.

## Resolve ambiguity safely

Do not infer unreadable labels, arrow directions, denominators, time units, incidence conventions, or whether a branch is mutually exclusive. Mark these as unresolved.

Ask one focused question when any unresolved point changes the equations. Examples include whether transmission is frequency-dependent (`beta * S * I / N`) or density-dependent (`beta * S * I`), whether a labelled arrow is per-capita, and whether a death arrow removes people from the total population.

Do not ask about standard implementation details that can be determined from the repository. Do not add compartments, transitions, or observation mechanisms that are not visible in the sketch or supplied by the user.

## Confirm the specification

Before implementation, present the extracted specification in concise prose and the transition table. State:

1. the model time unit;
2. the force-of-infection expression;
3. whether total population is expected to be conserved;
4. all assumptions approved by the user.

Only proceed to code after these points are unambiguous.
