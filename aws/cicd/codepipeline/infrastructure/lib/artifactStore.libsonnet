local bucketName = import 'bucketName.libsonnet';
local tags = import 'tags.libsonnet';

{
  resource: {
    aws_s3_bucket: {
      artifact_store: {
        bucket: bucketName('artifact-store'),
        acl: 'private',
        tags: tags(bucketName('artifact-store')),
      },
    },
  },
}
