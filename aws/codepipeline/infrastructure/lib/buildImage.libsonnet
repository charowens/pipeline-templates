local settings = import '../../settings.json';

settings.accountId+'.dkr.ecr.us-west-2.amazonaws.com/' + settings.docker.tag + ':' + settings.docker.version
