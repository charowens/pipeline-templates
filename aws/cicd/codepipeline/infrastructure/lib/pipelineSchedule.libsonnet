local merge = import 'merge.libsonnet';
local resourceName = import 'resourceName.libsonnet';

local rateExpression(minutes) =
  if minutes == 1 then 'rate(' + minutes + ' minute)'
  else 'rate(' + minutes + ' minutes)';

local schedulePipelineCloudWatchEvent(rateInMinutes) =
  local name = 'load-test-pipeline';
  {
    resource: {
      aws_cloudwatch_event_rule: {
        [name]: {
          name: resourceName(name),
          schedule_expression: rateExpression(rateInMinutes),
        },
      },
      aws_cloudwatch_event_target: {
        [name]: {
          rule: '${aws_cloudwatch_event_rule.' + name + '.name}',
          target_id: '${aws_codepipeline.platform_load_test.name}-target-' + name,
          arn: '${aws_codepipeline.platform_load_test.arn}',
          role_arn: '${aws_iam_role.pipeline.arn}',
        },
      },
    },
  };

merge([schedulePipelineCloudWatchEvent(720)]) # 12 hours