local settings = import '../../settings.json';

function(name)
  {
    terraform: [{
      backend: [{
        s3: {
          bucket: settings.tfState.bucket,
          key: settings.projectName + '/' + name,
          region: settings.tfState.region,
        },
      }],
    }],
  }
