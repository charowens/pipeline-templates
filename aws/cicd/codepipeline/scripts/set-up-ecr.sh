#!/bin/bash

##THIS is a prerequistie to publishing a new image
set -ve

aws ecr create-repository --repository-name $IMAGE_NAME --region us-west-2

aws ecr set-repository-policy \
    --repository-name $IMAGE_NAME \
    --region us-west-2
    --policy-text file://ecr-policy.json