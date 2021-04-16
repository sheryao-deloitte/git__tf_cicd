#=======================================================
# Outputs
#=======================================================
output "gke-cluster-endpoint" {
  value = module.gke-cluster.gke-endpoint
}

output "cluster" {
  value     = module.gke-cluster.cluster
  sensitive = true
}

output "username" {
  value     = module.gke-cluster.cluster.master_auth.0.username
  sensitive = true
}

output "password" {
  value     = module.gke-cluster.cluster.master_auth.0.password
  sensitive = true
}

output "cluster-ca-certificate" {
  value     = base64decode(module.gke-cluster.cluster.master_auth.0.cluster_ca_certificate)
  sensitive = true
}
