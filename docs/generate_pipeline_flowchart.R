library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)
library(here)

dot_code <- "
digraph pipeline {
  graph [layout = dot, rankdir = TB, nodesep = 0.6, ranksep = 0.45,
         pad = 0.18, bgcolor = 'white', fontname = Helvetica,
         splines = ortho]

  node [shape = box, style = 'rounded,filled', color = '#3f3f3f',
        penwidth = 1.3, fontname = Helvetica, fontsize = 10,
        width = 2.65, height = 0.62, margin = '0.15,0.10']
  edge [color = '#555555', penwidth = 1.2, arrowsize = 0.7]

  // --- Inputs ---
  sketch [label = 'Hand-drawn compartmental sketch\nPhotograph or scan', fillcolor = '#edf3f7', color = '#356d8d', penwidth = 1.8, width = 3.0]
  equations [label = 'Mathematical equations\nLaTeX, handwritten, or typed', fillcolor = '#edf3f7', color = '#356d8d', penwidth = 1.8, width = 3.0]

  subgraph cluster_extraction {
    label = 'Input extraction'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#356d8d'
    color = '#7d9eb3'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    setup [label = <<B>1. Project setup</B><BR/>R project structure and dependencies>, fillcolor = '#e8f1f8', color = '#356d8d']
    sketch_spec [label = <<B>2. Sketch specification</B><BR/>LLM vision extraction with confidence ratings>, fillcolor = '#e8f1f8', color = '#356d8d']
    eq_spec [label = <<B>3. Equation specification</B><BR/>Parse ODEs, parameters and initial conditions>, fillcolor = '#e8f1f8', color = '#356d8d']

    setup -> sketch_spec
    setup -> eq_spec
  }

  subgraph cluster_specification {
    label = 'Intermediate representation'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#8a6b21'
    color = '#c9a94e'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    transition_table [label = <<B>Transition table</B><BR/>Source, destination, flow, parameters, confidence>, fillcolor = '#fff4dd', color = '#9a6b16', penwidth = 1.8, width = 4.0]
  }

  subgraph cluster_review {
    label = 'Review and critique'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#356b49'
    color = '#7ea58a'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    critique [label = <<B>4. Model critique</B><BR/>Blocking defects, modelling concerns, optional extensions>, fillcolor = '#edf7ef', color = '#4f8660']
    user_critique [label = 'User', shape = oval, fillcolor = '#ffffff', color = '#555555', penwidth = 1.5, width = 1.0, height = 0.45]
  }

  subgraph cluster_implementation {
    label = 'Implementation'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#356d8d'
    color = '#7d9eb3'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    odin_path [label = <<B>5a. odin/odin2 + monty</B><BR/>ODE model, simulation script, particle filtering>, fillcolor = '#e8f1f8', color = '#356d8d', penwidth = 1.8]
    stan_path [label = <<B>5b. Stan + cmdstanr</B><BR/>Stan model file, HMC fitting script>, fillcolor = '#e8f1f8', color = '#356d8d', penwidth = 1.8]
  }

  subgraph cluster_observation {
    label = 'Observation model'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#8a6b21'
    color = '#c9a94e'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    obs_model [label = <<B>6. Observation model design</B><BR/>Likelihood, data mapping, priors>, fillcolor = '#fff4dd', color = '#9a6b16']
    user_obs [label = 'User', shape = oval, fillcolor = '#ffffff', color = '#555555', penwidth = 1.5, width = 1.0, height = 0.45]
  }

  subgraph cluster_validation {
    label = 'Validation and traceability'
    fontname = 'Helvetica-Bold'
    fontsize = 10
    fontcolor = '#356b49'
    color = '#7ea58a'
    penwidth = 1.2
    style = 'rounded,dashed'
    margin = 18

    validation [label = <<B>7. Validation</B><BR/>Compilation, mass balance, diagnostics>, fillcolor = '#edf7ef', color = '#4f8660']
    traceability [label = <<B>8. Traceability</B><BR/>Audit trail from source to tested code>, fillcolor = '#edf7ef', color = '#4f8660']

    validation -> traceability
  }

  // --- Outputs ---
  outputs [label = 'Validated model code\nSimulation script, diagram, audit trail', fillcolor = '#e7f5e7', color = '#33804a', penwidth = 1.8, width = 3.5]

  // --- Edges ---
  sketch -> sketch_spec
  equations -> eq_spec

  sketch_spec -> transition_table
  eq_spec -> transition_table

  transition_table -> critique

  critique -> user_critique [style = dashed, color = '#9a6b16']
  user_critique -> critique [style = dashed, color = '#9a6b16', label = '  resolve ambiguities', fontsize = 8, fontcolor = '#9a6b16']

  critique -> odin_path
  critique -> stan_path

  odin_path -> obs_model
  stan_path -> obs_model

  obs_model -> user_obs [style = dashed, color = '#9a6b16']
  user_obs -> obs_model [style = dashed, color = '#9a6b16', label = '  approve observation model', fontsize = 8, fontcolor = '#9a6b16']

  obs_model -> validation

  traceability -> outputs
}
"

viz <- grViz(dot_code)

dir.create(here("docs"), recursive = TRUE, showWarnings = FALSE)

svg_code <- export_svg(viz)
rsvg_png(charToRaw(svg_code), file = here("docs", "pipeline_flowchart.png"), width = 1800)

cat("Flowchart generated at: docs/pipeline_flowchart.png\n")
