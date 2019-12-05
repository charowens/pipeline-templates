local bucketName = import 'bucketName.libsonnet';

{
  resource: {
    aws_s3_bucket: {
      release: {
        bucket: bucketName('release'),
        acl: 'private',
      },
    },
  },
}
