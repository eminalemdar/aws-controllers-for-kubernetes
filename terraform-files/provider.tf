terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "aws" {
  region  = var.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.eks_cluster_certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks_cluster.eks_cluster_id]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks_cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks_cluster.eks_cluster_id]
    }
  }
}