local singleActionStage = import 'singleActionStage.libsonnet';

function(title) singleActionStage(title, 'Build', input='source', output='buildPackage')
