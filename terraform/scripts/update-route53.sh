#!/bin/bash

set -x

if [ "$#" -ne 2 ]; then
    echo
    echo "Error: Incorrect amount of parameters."
    echo
    echo "Usage: $0, 1 - Zone ID (Str), 2 - ELB Endpoint (Str)"
    exit 1
fi

echo $1 #$1 Zone ID
echo $2 #$2 Elb Endpoint

echo "Update Edge cluster apps such as ArgoCD, Argo Workflow UI Access Hostnames in Route53 Zone ID: $1 with endpoint $2"
sed "s^#ELB_HOSTNAME_ENDPOINT#^$2^g" route53.json > tmp-route53.json
aws route53 change-resource-record-sets --hosted-zone-id $1 --change-batch file://tmp-route53.json

#outout argo cd and argo workflow ui dashboards
echo "https://argocd.nightly.edge.collibra.dev:30443"
echo "https://argowf.nightly.edge.collibra.dev:30444"

    
