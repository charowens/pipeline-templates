local settings = import '../../settings.json';
local resourceName = import 'resourceName.libsonnet';

function(name)
  {
    ApplicationCode: settings.applicationCode,
    application_id: settings.applicationId,
    Name: name,
    environment: settings.projectName,
    Subsystem: 'NA',
    arch_compliance: 'NA',
    business_unit: 'Enterprise-CCNA',
    'cpm backup': 'no backup',
    dr_class: '2',
    host_name: 'SERVERLESS',
    infra_msp: 'CCNA-IT-OPS',
    puppet_managed: 'not_managed',
    puppet_role: 'NA',
    security_tier: '2',
    terraform_managed: 'managed',
  }
