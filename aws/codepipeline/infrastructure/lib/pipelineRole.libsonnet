local resourceName = import 'resourceName.libsonnet';
local tags = import 'tags.libsonnet';

{
  data: {
    aws_iam_policy_document: {
      pipeline: {
        statement: [
                    {
          actions: [
            's3:GetObject',
            's3:GetObjectVersion',
            's3:GetBucketVersioning',
                        ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}',
            '${aws_s3_bucket.artifact_store.arn}/*',
          ],
        }, {
          actions: [
            'codebuild:BatchGetBuilds',
            'codebuild:StartBuild',
            'codepipeline:StartPipelineExecution',
          ],
          resources: ['*'],
        }, {
          actions: [
            'codecommit:Get*',
            'codecommit:*Archive*',
          ],
          resources: [
            '*',
          ],
        }, {
          actions: [
            's3:*',
          ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}',
            '${aws_s3_bucket.artifact_store.arn}/*',
            '${aws_s3_bucket.release.arn}',
            '${aws_s3_bucket.release.arn}/*',
            'arn:aws:s3:::*/*',
            'arn:aws:s3:::*'
          ],
        }, {
          actions: [
              "cloudwatch:*",
              "dynamodb:*",
              "appsync:*",
              "sqs:*",
              "sns:*",
              "lambda:*",
              "logs:*",
              "apigateway:*",
              "rds:DescribeDBInstances",
              "iam:List*",
              "iam:Get*",
              "ec2:GetConsoleScreenshot",
              "ec2:Describe*",
              "elasticloadbalancing:Describe*",
              "cloudtrail:DescribeTrails",
              "cloudtrail:GetTrailStatus",
              "cloudtrail:LookupEvents",
              "cloudformation:DescribeStackResources",
              "kms:ListAliases",
              "events:*",
              "tag:Get*",
              "cognito-idp:DescribeUserPool",
              "cloudfront:GetDistribution",
              "cloudfront:GetCloudFrontOriginAccessIdentity",
              "codecommit:ListRepositories",
              "cognito-idp:DescribeUserPoolClient",
              "cloudfront:ListTagsForResource",
              "firehose:Describe*",
              "firehose:List*"
          ],
          resources:  [
              "*"
          ]
        }, {
          actions: [
              "iam:GetRole",
              "iam:PassRole"
          ],
            resources:[
              "arn:aws:iam::*:role/*"
          ]
        }, {
          actions: [
              "iam:AttachRolePolicy",
              "iam:CreateRole",
              "iam:CreateServiceLinkedRole",
              "iam:DeleteRole",
              "iam:DeleteRolePolicy",
              "iam:DeleteServiceLinkedRole",
              "iam:DetachRolePolicy",
              "iam:GetRole",
              "iam:GetRolePolicy",
              "iam:ListAttachedRolePolicies",
              "iam:ListInstanceProfilesForRole",
              "iam:ListRolePolicies",
              "iam:PassRole",
              "iam:PutRolePolicy",
              "iam:TagRole",
              "iam:UpdateAssumeRolePolicy",
              "iam:UpdateRoleDescription"
          ],
            resources: [
              "arn:aws:iam::*:role/*"
          ]
        }, {
          actions: [
            "iam:CreatePolicy",
            "iam:CreatePolicyVersion",
            "iam:DeletePolicy",
            "iam:DeletePolicyVersion",
            "iam:GetPolicy",
            "iam:GetPolicyVersion",
            "iam:ListEntitiesForPolicy",
            "iam:ListPolicyVersions",
            "iam:SetDefaultPolicyVersion"
        ],
          resources: [
              "arn:aws:iam::*:policy/*"
          ]
        }],
      },
      pipeline_assume: {
        statement: [{
          actions: ['sts:AssumeRole'],
          principals: [{
            type: 'Service',
            identifiers: [
              'codepipeline.amazonaws.com',
              'events.amazonaws.com',
            ],
          }],
        }],
      },
    },
  },
  resource: {
    aws_iam_role: {
      pipeline: {
        name: resourceName('pipeline'),
        assume_role_policy: '${data.aws_iam_policy_document.pipeline_assume.json}',
        tags: tags(resourceName('pipeline')),
      },
    },
    aws_iam_role_policy: {
      pipeline: {
        role: '${aws_iam_role.pipeline.id}',
        policy: '${data.aws_iam_policy_document.pipeline.json}',
      },
    },
  },
}
