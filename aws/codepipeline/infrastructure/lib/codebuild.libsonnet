local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local pipeCase = import 'pipeCase.libsonnet';
local snakeCase = import 'snakeCase.libsonnet';
local tags = import 'tags.libsonnet';

function(pipelineTitle, actionTitle, environment=null, timeout=60)
  local combined = pipelineTitle + ' ' + actionTitle;
  local key = snakeCase(combined);
  local name = pipeCase(settings.projectName + ' ' + combined);
  local buildspec = 'buildspec/'+'buildspec-' + pipeCase(actionTitle) + '.yml';
  local computeType = if environment == null then 'BUILD_GENERAL1_MEDIUM' else if std.objectHas(environment, 'computeType') then environment.computeType else 'BUILD_GENERAL1_MEDIUM';
  local privilegedMode = if environment == null then false else if std.objectHas(environment, 'privilegedMode') then environment.privilegedMode else false;
  {
    resource: {
      aws_codebuild_project: {
        [key]: {
          name: name,
          service_role: '${aws_iam_role.codebuild.arn}',
          build_timeout: timeout,
          environment: [{
            compute_type: computeType,
            type: 'LINUX_CONTAINER',
            image: buildImage,
            privileged_mode: privilegedMode,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: buildspec,
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(name),
        },
      },
    },
  }
