################################################################################
# Cluster Data
################################################################################

output "cluster_id" {
  description = "eks_cluster cluster ID."
  value       = module.eks_cluster.eks_cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for eks_cluster control plane."
  value       = module.eks_cluster.eks_cluster_endpoint
}