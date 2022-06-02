#!/bin/bash
: '
The following script cleans up the resources created in
this repository gracefully.
'
declare SERVICE="$1"
declare AWS_REGION="eu-west-1"
declare ACK_SYSTEM_NAMESPACE="ack-system"

cleanup(){

  echo "===================================================="
  echo "Creating required Environment Variables."
  echo "===================================================="

  declare CHART_EXPORT_PATH="/tmp/chart"
  declare ACCOUNT_ID=$(aws sts get-caller-identity | python3 -c "import sys,json; print (json.load(sys.stdin)['Account'])")
  declare EKS_CLUSTER_NAME="eks-cluster-for-ack"
  declare OIDCURL=$(aws eks describe-cluster --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION} --query "cluster.identity.oidc.issuer" --output text  | python3 -c "import sys; print (sys.stdin.readline().replace('https://',''))")

  echo "===================================================="
  echo "Uninstalling the ACK Service Controller."
  echo "===================================================="  

  helm uninstall -n "$ACK_SYSTEM_NAMESPACE" ack-${SERVICE}-controller

  echo "===================================================="
  echo "Deleting the CRDs for Service Controllers."
  echo "====================================================" 
  
  kubectl delete -f ${CHART_EXPORT_PATH}/${SERVICE}-chart/crds

  echo "===================================================="
  echo "Deleting the Kubernetes Namespace."
  echo "====================================================" 

  kubectl delete namespace "$ACK_SYSTEM_NAMESPACE"

  echo "===================================================="
  echo "Deleting the OIDC Provider."
  echo "====================================================" 

  aws iam delete-open-id-connect-provider --open-id-connect-provider-arn arn:aws:iam::${ACCOUNT_ID}:oidc-provider/${OIDCURL}

  echo "===================================================="
  echo "Deleting the EKS Cluster."
  echo "====================================================" 

  cd terraform-files/
  terraform destroy --auto-approve
}

cleanup "$SERVICE"