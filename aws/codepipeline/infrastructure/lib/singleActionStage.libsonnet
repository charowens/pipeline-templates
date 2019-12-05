local actionStage = import 'actionStage.libsonnet';

// a stage with a single action

function(pipelineTitle, title, input=null, output=null, runOrder=null)
  actionStage(pipelineTitle, title, [
    { title: title, inputs: [input], output: output, runOrder:runOrder },
  ])
