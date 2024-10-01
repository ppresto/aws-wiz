#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)


EKS_CLUSTER_NAME=wiz-code-eks-cluster
REGION="us-west-2"

echo "Authenticating to EKS Cluster ${EKS_CLUSTER_NAME} - ${REGION}"
# get identity
aws sts get-caller-identity
# add EKS cluster to $HOME/.kube/config
aws eks --region $REGION update-kubeconfig --name $EKS_CLUSTER_NAME --alias "wiz" 