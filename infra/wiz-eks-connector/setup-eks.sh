#!/bin/zsh

. ./setenv.sh

helm repo add wiz-sec https://charts.wiz.io/
helm repo update

kubectl create namespace wiz

kubectl -n wiz create secret docker-registry sensor-image-pull \
  --docker-server=wizio.azurecr.io/sensor \
  --docker-username=$SENSOR_PULLKEY_USERNAME \
  --docker-password=$SENSOR_PULLKEY_PASSWORD
  
kubectl -n wiz create secret generic wiz-api-token \
  --from-literal clientId=$WIZ_SERVICE_ACCOUNT_ID \
  --from-literal clientToken=$WIZ_SERVICE_ACCOUNT_TOKEN

helm install wiz-integration wiz-sec/wiz-kubernetes-integration --values ./wiz-values.yaml -n wiz