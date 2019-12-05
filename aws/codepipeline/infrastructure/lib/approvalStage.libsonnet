local pascalCase = import 'pascalCase.libsonnet';

function(title=null)
  local name = pascalCase(if title == null then 'Approval' else title);
  {
    name: name,
    action: [{
      name: name,
      category: 'Approval',
      provider: 'Manual',
      version: '1',
      owner: 'AWS',
    }],
  }
