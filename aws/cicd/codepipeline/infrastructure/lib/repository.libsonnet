local settings = import '../../settings.json';
local tags = import 'tags.libsonnet';

function(title, desc)
  local lowercase = std.asciiLower(title);
  local key = std.strReplace(lowercase, ' ', '_');
  local name = settings.projectName + '-' + std.strReplace(lowercase, ' ', '-');
  {
    resource: {
      aws_codecommit_repository: {
        [key]: {
          repository_name: name,
          default_branch: 'master',
          description: desc,
          tags: tags(name),
        },
      },
    },
  }
