local action = import 'action.libsonnet';
local actionStage = import 'actionStage.libsonnet';
local approvalStage = import 'approvalStage.libsonnet';
local buildStage = import 'buildStage.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local merge = import 'merge.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local postBuildAction = import 'postBuildAction.libsonnet';
local postBuildStage = import 'postBuildStage.libsonnet';
local repository = import 'repository.libsonnet';
local singleActionStage = import 'singleActionStage.libsonnet';

local base(title, description, stages) =
  merge([
    repository(title, description),
    pipeline(
      title,
      stages=[
        if stage.type == 'build' then buildStage(title)
        else if stage.type == 'action' then actionStage(title, stage.title, [
          if !std.objectHas(stageAction, 'type') then action(
            stageAction.title,
            inputs=if std.objectHas(stageAction, 'inputs') then stageAction.inputs else null,
            output=if std.objectHas(stageAction, 'output') then stageAction.output else null,
            runOrder=if std.objectHas(stageAction, 'runOrder') then stageAction.runOrder else null,

          )
          else if stageAction.type == 'post-build' then postBuildAction(
            stageAction.title,
            output=if std.objectHas(stageAction, 'output') then stageAction.output else null,
            runOrder=if std.objectHas(stageAction, 'runOrder') then stageAction.runOrder else null
          )
          for stageAction in stage.actions
        ])
        else if stage.type == 'single-action' then singleActionStage(
          title,
          stage.title,
          input=if std.objectHas(stage, 'input') then stage.input else null,
          output=if std.objectHas(stage, 'output') then stage.output else null,
        )
        else if stage.type == 'approval' then approvalStage(title=if std.objectHas(stage, 'title') then stage.title else null)
        else if stage.type == 'post-build' then postBuildStage(title, stage.title)
        else error 'unknown stage type ' + stage.type
        for stage in stages
      ],
    ),
  ]);

local buildCodebuilds(title, stages) =
  merge([
    codebuild(title, 'Build')
    for stage in stages
    if stage.type == 'build'
  ]);

local nonBuildCodebuilds(title, stages) =
  merge([
    codebuild(title, stage.title,
      environment=if std.objectHas(stage, 'environment') then stage.environment,
      timeout=if std.objectHas(stage, 'timeout') then stage.timeout,
    )
    for stage in stages
    if stage.type != 'build' && stage.type != 'approval' && stage.type != 'action'
  ]);

local nestedCodebuilds(title, stages) =
  merge([
    codebuild(title, stageAction.title, 
      environment=if std.objectHas(stageAction, 'environment') then stageAction.environment,
      timeout=if std.objectHas(stageAction, 'timeout') then stageAction.timeout
    )
    for stage in stages
    if stage.type == 'action'
    for stageAction in stage.actions
  ]);

function(title, description, stages)
  merge([
    base(title, description, stages),
    buildCodebuilds(title, stages),
    nonBuildCodebuilds(title, stages),
    nestedCodebuilds(title, stages),
  ])
