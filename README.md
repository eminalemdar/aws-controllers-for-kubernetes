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

Terraform codes in this repository uses [Amazon EKS Blueprints for Terraform](https://aws-ia.github.io/terraform-aws-eks-blueprints/main/)

Terraform codes in this repository creates following resources:

- VPC with 6 subnets (3 Private, 3 Public)

- EKS Cluster with Kubernetes version set to 1.22

- EKS Managed Node group

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

You can connect to your cluster using this command:

```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

> You need to change `region` and `cluster_name` parameters.

### Installation of a Service Controller

When you want to install a Service Controller and configure IAM Permissions you can run `./ack_controller_install.sh <service_name>` and change the *service_name* accordingly.

The [script](./ack_controller_install.sh) has two functions called install and permissions.

- Install function downloads the required Helm Chart from the official AWS Registry installs it to the Kubernetes cluster.

- Permissions function creates OIDC identity provider for the Kubernetes cluster and creates IAM Roles for for Service Accounts of the Service Controllers.

### Cleanup

When you want to delete all the resources created in this repository, you can run `./cleanup.sh <service_name>` script in the root directory of this repository and change the *service_name* accordingly.

The [script](./cleanup.sh) has one function and does the following:

- Uninstalls the Helm Chart for Service Controller

- Deletes the CRDs created for Service Controller

- Deletes the OIDC Provider of EKS Cluster

- Deletes the EKS Cluster created with Terraform
