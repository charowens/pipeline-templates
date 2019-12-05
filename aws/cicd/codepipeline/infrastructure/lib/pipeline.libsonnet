local settings = import '../../settings.json';
local tags = import 'tags.libsonnet';

function(title, stages)
  local lowercase = std.asciiLower(title);
  local key = std.strReplace(lowercase, ' ', '_');
  local name = settings.projectName + '-' + std.strReplace(lowercase, ' ', '-');
  {
    resource: {
      aws_codepipeline: {
        [key]: {
          name: name,

          role_arn: '${aws_iam_role.pipeline.arn}',

          artifact_store: {
            type: 'S3',
            location: '${aws_s3_bucket.artifact_store.bucket}',
          },

          stage: [
            {
              name: 'Source',
              action: [
                {
                  name: 'Source',
                  category: 'Source',
                  provider: 'CodeCommit',
                  version: '1',
                  owner: 'AWS',
                  configuration: {
                    RepositoryName: '${aws_codecommit_repository.' + key + '.repository_name}',
                    BranchName: 'master',
                  },
                  output_artifacts: ['source'],
                },
              ],
            },
          ] + stages,
          tags: tags(name),
        },
      },
    },
  }
