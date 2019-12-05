local settings = import '../../settings.json';

function(name)
  std.join('-', [settings.projectName,name, settings.s3Suffix])
