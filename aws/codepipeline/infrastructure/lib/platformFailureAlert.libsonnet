local resourceName = import 'resourceName.libsonnet';

{
  data: {
    aws_iam_policy_document: {
      platform_failure: {
        statement: [{
          actions: ['SNS:Publish'],
          principals: {
            type: 'Service',
            identifiers: ['events.amazonaws.com'],
          },
          resources: ['${aws_sns_topic.platform_failure.arn}'],
        }],
      },
    },
  },
  resource: {
    aws_sns_topic: {
      platform_failure: {
        name: resourceName('failure'),
      },
    },
    aws_cloudwatch_event_rule: {
      platform_failure: {
        name: resourceName('failure'),
        event_pattern: std.toString({
          source: ['aws.codepipeline'],
          'detail-type': ['CodePipeline Pipeline Execution State Change'],
          detail: {
            state: ['FAILED'],
          },
        }),
      },
    },
    aws_sns_topic_policy: {
      platform_failure: {
        arn: '${aws_sns_topic.platform_failure.arn}',
        policy: '${data.aws_iam_policy_document.platform_failure.json}',
      },
    },
    aws_cloudwatch_event_target: {
      platform_failure: {
        rule: '${aws_cloudwatch_event_rule.platform_failure.name}',
        target_id: 'SendToSNS',
        arn: '${aws_sns_topic.platform_failure.arn}',
        input_transformer: {
          input_paths: {
            time: '$.time',
            pipeline: '$.detail.pipeline',
          },
          input_template: '"The <pipeline> pipeline failed at <time>"',
        },
      },
    },
  },
}
