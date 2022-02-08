#!/bin/bash

set -e

NameSpaceExists=$(kubectl get ns monitoring -o json | jq .status.phase -r)

if [ $NameSpaceExists == "Active" ]; then
  echo "Namespace monitoring already exists"

else
  echo "Namespace monitoring is created"

  kubectl create namespace monitoring

fi

InfluxdbCredsExists=$(kubectl get secret influxdb-creds -n monitoring -o json | jq .type -r)
if [ $InfluxdbCredsExists == "Opaque" ]; then
  echo "Secret already exists"

else

kubectl create secret generic influxdb-creds \
  --from-literal=INFLUXDB_DB=monitoring \
  --from-literal=INFLUXDB_READ_USER=readonly \
  --from-literal=INFLUXDB_USER_PASSWORD=changemeplease \
  --from-literal=INFLUXDB_ADMIN_USER=admin \
  --from-literal=INFLUXDB_ADMIN_USER_PASSWORD=changemeplease \
  --from-literal=INFLUXDB_HOST=influxdb  \
  --from-literal=INFLUXDB_HTTP_AUTH_ENABLED=true

fi

kubectl apply -f influxdb-pvc.yml -n monitoring
kubectl apply -f influxdb-config.yaml -n monitoring
kubectl apply -f influxdb-nodeport.yaml -n monitoring
kubectl apply -f influxdb-deployment.yaml -n monitoring
kubectl apply -f influxdb-ingress.yaml -n monitoring

