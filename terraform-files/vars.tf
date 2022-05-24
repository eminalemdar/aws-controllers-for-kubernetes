variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

variable "cluster_name" {
  default = "eks-cluster-for-ack"
}

variable "vpc_name" {
  default = "eks-vpc"
}