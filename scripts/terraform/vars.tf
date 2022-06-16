variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

variable "cluster_name" {
  default = "eks-cluster-for-ack"
}

variable "cluster_version" {
  default = "1.22"
  description = "Kubernetes version of the EKS Cluster"
}

variable "vpc_name" {
  default = "eks-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}