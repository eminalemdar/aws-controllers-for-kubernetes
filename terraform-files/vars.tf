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

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}