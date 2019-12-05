local settings = import '../../settings.json';
local pascalCase = import 'pascalCase.libsonnet';
local snakeCase = import 'snakeCase.libsonnet';

function(pipelineTitle, actionTitle, inputs=null, output=null, runOrder=null)
  local key = snakeCase(pipelineTitle + ' ' + actionTitle);
  local ProjectName = '${aws_codebuild_project.' + key + '.name}';
  {
    name: pascalCase(actionTitle),
    category: 'Build',
    provider: 'CodeBuild',
    version: '1',
    owner: 'AWS',
    configuration: {
      ProjectName: ProjectName,
      [if std.length(inputs) > 1 then 'PrimarySource']: inputs[0],
    },
    [if inputs != null then 'input_artifacts']: inputs,
    [if output != null then 'output_artifacts']: [output],
    [if runOrder !=null then 'run_order']:runOrder

  }
