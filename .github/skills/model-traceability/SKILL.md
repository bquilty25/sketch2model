---
name: model-traceability
description: Preserve a reproducible audit trail from a compartment-sketch image through decisions, model code, diagrams, and validation.
---

# Model traceability

Keep the source sketch unchanged. Following the repository's existing layout, save a machine-readable transcription and a human-readable assumptions and decisions record beside the generated model.

Record the source image filename or checksum, extraction confidence, unresolved ambiguities, user decisions, model time unit, transition table, equation version, generated-diagram path, parameter interface, and validation outcomes.

Link the traceability record to the model-definition and validation files using relative `here::here()` paths. Record factual decisions only, without embedding unapproved epidemiological assumptions.
