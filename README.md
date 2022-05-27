# AWS Controllers for Kubernetes (ACK) examples

This repository consists of examples for the AWS Controllers for Kubernetes [(ACK)](https://aws-controllers-k8s.github.io/community/). ACK allows you to create AWS Resources on your behalf from Kubernetes Clusters with simple Kubernetes YAML files.

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

### Installation of a Service Controller

When you want to install a Service Controller and configure IAM Permissions you can run `./ack_controller_install.sh <service_name>` and change the *service_name* accordingly.

The [script](./ack_controller_install.sh) has two functions called install and permissions.

- Install function downloads the required Helm Chart from the official AWS Registry installs it to the Kubernetes cluster.

- Permissions function creates OIDC identity provider for the Kubernetes cluster and creates IAM Roles for for Service Accounts of the Service Controllers.

> The Terraform script in this repository configures IRSA when launching EKS Cluster.
> If you have used this Terraform script when installing your Kubernetes Cluster,
> You can comment out the sections in the script for skipping that part.
