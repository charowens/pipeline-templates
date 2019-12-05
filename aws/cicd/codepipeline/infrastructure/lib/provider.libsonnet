local settings = import '../../settings.json';

{
  provider: {
    aws: {
      region: settings.region,
      allowed_account_ids: [settings.accountId],
    } + (if settings.deployRoleARN != null then {
           assume_role: {
             role_arn: settings.deployRoleARN,
           },
         } else {
         }),
  },
}
