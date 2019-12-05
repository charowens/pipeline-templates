local settings = import '../../settings.json';

function(name)
  std.join('-', [settings.projectName, 'pipeline', name])
