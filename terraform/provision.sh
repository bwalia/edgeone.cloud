#!/bin/bash
  
set -x

workDir=/Users/balinderwalia/Documents/Work/edgeone/terraform

echo $workDir

cd /Users/balinderwalia/Documents/Work/go/go-services-manager/

./build.sh

cd $workDir

echo $pwd

export AWS_SDK_LOAD_CONFIG=1

echo "Provisioning edgeone default tenant infra..."

if [ -z ${AWS_PROFILE} ];
then
  AWS_PROFILE=default
fi

if [ -z ${AWS_REGION} ];
then
  AWS_REGION=eu-west-2
fi

terraform import aws_vpc.prod-vpc vpc-b86529d1

terraform init

#terraform plan

terraform apply --auto-approve

/bin/bash update-dynomite.sh
