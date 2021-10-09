#!/bin/bash

set -x

#terraform import aws_vpc.prod-vpc vpc-b86529d1
terraform state rm aws_vpc.prod-vpc

terraform destroy
