local subProjects = import '../subProjects.json';

local backend = import 'lib/backend.libsonnet';
local merge = import 'lib/merge.libsonnet';
local provider = import 'lib/provider.libsonnet';

local artifactStore = import 'lib/artifactStore.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';
// local pipelineSchedule = import 'lib/pipelineSchedule.libsonnet';
local releaseBucket = import 'lib/releaseBucket.libsonnet';
// local secretsManager = import 'lib/secretsManager.libsonnet';

local repository = import 'lib/repository.libsonnet';
local subProject = import 'lib/subProject.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  // secretsManager,
  codeBuildRole,
  pipelineRole,
  // pipelineSchedule,
  platformFailureAlert,
] + [
  subProject(subProjectDefinition.title, subProjectDefinition.description, subProjectDefinition.stages)
  for subProjectDefinition in subProjects
  if std.objectHas(subProjectDefinition, 'stages')
] + [
  repository(subProjectDefinition.title, subProjectDefinition.description)
  for subProjectDefinition in subProjects
  if !std.objectHas(subProjectDefinition, 'stages')
])
