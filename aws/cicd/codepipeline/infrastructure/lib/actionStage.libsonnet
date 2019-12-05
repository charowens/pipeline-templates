local pascalCase = import 'pascalCase.libsonnet';
local pipelineAction = import 'pipelineAction.libsonnet';

function(pipelineTitle, stageTitle, actions)
  {
    name: pascalCase(stageTitle),
    action: [
      pipelineAction(
        pipelineTitle,
        action.title,
        inputs=if std.objectHas(action, 'inputs') then action.inputs else null,
        output=if std.objectHas(action, 'output') then action.output else null,
        runOrder=if std.objectHas(action, 'runOrder') then action.runOrder else null

      )
      for action in actions
    ],
  }
