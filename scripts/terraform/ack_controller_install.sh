#!/bin/bash
: '
The following script has two functions with different actions

Install function downloads the required Helm Chart
for the Service Controller and installs it
on the Kubernetes cluster.
Permissions function creates required IRSA config
and configures required IAM Permissions for the 
Service Controller and connects those to the
service account.
'
declare SERVICE="$1"
declare AWS_REGION="eu-west-1"
declare ACK_SYSTEM_NAMESPACE="ack-system"

install(){
  
  echo "===================================================="
  echo "Creating required Environment Variables."
  echo "===================================================="
  
  # Setting the Environment variables for Service Controller Helm Chart
  # declare -i HELM_EXPERIMENTAL_OCI=1 # Only required for Helm below v3.8.0
  declare RELEASE_VERSION=$(curl -sL https://api.github.com/repos/aws-controllers-k8s/${SERVICE}-controller/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
  declare CHART_REPO="public.ecr.aws/aws-controllers-k8s/${SERVICE}-chart"
  
  echo "===================================================="
  echo "Installing the Service Controller Helm Chart."
  echo "===================================================="
  
  # Log into the ECR Public OCI repository
  aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin public.ecr.aws

  # Pulling the Helm Chart from Official AWS Registry and installing it.  
  helm install --create-namespace --namespace "$ACK_SYSTEM_NAMESPACE" ack-${SERVICE}-controller \
      --set aws.region="$AWS_REGION" oci://${CHART_REPO}
}

#####################################################################################################################
#####################################################################################################################

permissions(){

  echo "===================================================="
  echo "Creating IRSA for EKS Cluster"
  echo "===================================================="

  ###########################################################
  # You can skip this step if you have already configured   #
  # IRSA for your Kubernetes Cluster.                       #
  ###########################################################
  
  declare EKS_CLUSTER_NAME="eks-cluster-for-ack"
  eksctl utils associate-iam-oidc-provider --cluster ${EKS_CLUSTER_NAME} --region ${AWS_REGION} --approve

  echo "===================================================="
  echo "Creating Required IAM Role and Policy"
  echo "===================================================="

  # Setting the required parameters for OIDC Provider.
  AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
  OIDC_PROVIDER=$(aws eks describe-cluster --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION} --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")

  ACK_K8S_SERVICE_ACCOUNT_NAME=ack-${SERVICE}-controller

  # Creating IAM Trust Policy. 
  read -r -d '' TRUST_RELATIONSHIP <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::${AWS_ACCOUNT_ID}:oidc-provider/${OIDC_PROVIDER}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "${OIDC_PROVIDER}:sub": "system:serviceaccount:${ACK_SYSTEM_NAMESPACE}:${ACK_K8S_SERVICE_ACCOUNT_NAME}"
          }
        }
      }
    ]
  }
EOF
  echo "${TRUST_RELATIONSHIP}" > trust.json

  # Setting the required Environment Variables for IRSA (IAM Roles for Service Accounts).
  ACK_CONTROLLER_IAM_ROLE="ack-${SERVICE}-controller"
  ACK_CONTROLLER_IAM_ROLE_DESCRIPTION='IRSA role for ACK $SERVICE controller deployment on EKS cluster using Helm charts'
  aws iam create-role --role-name "${ACK_CONTROLLER_IAM_ROLE}" --assume-role-policy-document file://trust.json --description "${ACK_CONTROLLER_IAM_ROLE_DESCRIPTION}"
  ACK_CONTROLLER_IAM_ROLE_ARN=$(aws iam get-role --role-name=${ACK_CONTROLLER_IAM_ROLE} --query Role.Arn --output text)

  echo "===================================================="
  echo "Attaching the policy to the IAM Role"
  echo "===================================================="

  # Environment variables for required ARNs.
  BASE_URL=https://raw.githubusercontent.com/aws-controllers-k8s/${SERVICE}-controller/main
  POLICY_ARN_URL=${BASE_URL}/config/iam/recommended-policy-arn
  POLICY_ARN_STRINGS="$(wget -qO- ${POLICY_ARN_URL})"

  INLINE_POLICY_URL=${BASE_URL}/config/iam/recommended-inline-policy
  INLINE_POLICY="$(wget -qO- ${INLINE_POLICY_URL})"

  # Attaching the policy to the IAM Role.
  while IFS= read -r POLICY_ARN; do
      echo -n "Attaching ${POLICY_ARN} ... "
      aws iam attach-role-policy \
          --role-name "${ACK_CONTROLLER_IAM_ROLE}" \
          --policy-arn "${POLICY_ARN}"
      echo "ok."
  done <<< "$POLICY_ARN_STRINGS"

  if [ ! -z "${INLINE_POLICY}" ]; then
      echo -n "Putting inline policy ... "
      aws iam put-role-policy \
          --role-name "${ACK_CONTROLLER_IAM_ROLE}" \
          --policy-name "ack-recommended-policy" \
          --policy-document "${INLINE_POLICY}"
      echo "ok."
  fi

  echo "===================================================="
  echo "Associating the Role with the Service Account"
  echo "===================================================="

  # Updating the Kubernetes Service Account with the new IAM Role
  declare IRSA_ROLE_ARN=eks.amazonaws.com/role-arn=${ACK_CONTROLLER_IAM_ROLE_ARN}
  kubectl annotate serviceaccount -n ${ACK_SYSTEM_NAMESPACE} ${ACK_K8S_SERVICE_ACCOUNT_NAME} ${IRSA_ROLE_ARN}

  # Note the deployment name for ACK service controller from following command
  ACK_DEPLOYMENT_NAME=$(kubectl get deployments -n ${ACK_SYSTEM_NAMESPACE} --no-headers | grep "$SERVICE" | awk '{print $1}')
  kubectl -n ${ACK_SYSTEM_NAMESPACE} rollout restart deployment "$ACK_DEPLOYMENT_NAME"
}

install "$SERVICE"
permissions "$SERVICE"