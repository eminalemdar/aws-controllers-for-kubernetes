# AWS Controllers for Kubernetes (ACK) examples

This repository consist examples for AWS Controllers for Kubernetes [(ACK)](https://aws-controllers-k8s.github.io/community/). ACK allows you to create AWS Resources on your behalf from Kubernetes Clusters with simple Kubernetes YAML files.

## Prerequisites

- A Kubernetes Cluster

- AWS IAM Permissions for creating and attaching IAM Roles

- Installation of required tools:

  - [AWS CLI](https://aws.amazon.com/cli/)

  - [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

  - [Helm](https://helm.sh/docs/intro/install/)

  - [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform)

  - [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)

If you don't have a Kubernetes cluster, you can create an EKS cluster with Terraform using the [example codes](./terraform-files/) within this repository.

## Terraform Codes

Terraform codes in this repository creates following resources:

- VPC with 6 subnets (3 Private, 3 Public)

- Security Group for Worker Instances in EKS Cluster

- EKS Cluster with Kubernetes version set to 1.22

- EKS Managed Node group

- Enable IAM Roles for Service Accounts (IRSA) for EKS Cluster

> You can update the Terraform codes according to your requirements and environment.

### Installation of EKS Cluster

```shell
terraform init
terraform plan
terraform apply --auto-approve
```

> PS:
>
> - These resources are not Free Tier eligible.
> - You need to configure AWS Authentication for Terraform with either [Environment Variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-set) or AWS CLI [named profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html#cli-configure-profiles-create).
