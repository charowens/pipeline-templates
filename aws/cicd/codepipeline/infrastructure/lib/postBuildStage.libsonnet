local singleActionStage = import 'singleActionStage.libsonnet';

// a single action stage that takes the build package from the build stage as its input

function(pipelineTitle, title) singleActionStage(pipelineTitle, title, input='buildPackage')
