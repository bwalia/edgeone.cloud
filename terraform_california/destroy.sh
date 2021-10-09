#!/bin/bash

set -x
cd /Users/balinderwalia/Documents/Work/edgeone/terraform_singapore/

#terraform import aws_vpc.prod-vpc vpc-b86529d1
/usr/local/bin/terraform state rm aws_vpc.prod-vpc

/usr/local/bin/terraform destroy
