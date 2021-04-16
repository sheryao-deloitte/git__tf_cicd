#=======================================================
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google = {
      version = "~> 3.50.0"
    }
  }
}

#=======================================================
# Provider
#=======================================================
provider "google" {
  project = var.id-project
  region  = var.location
}

#=======================================================
# Data Sources
#=======================================================
data "google_container_engine_versions" "gkeversion" {
  location = var.location
  project  = var.id-project
}

data "google_compute_network" "vpc-cluster" {
  name = var.name-vpc
}

#=======================================================
# Local Variables
# (null_triggers for Post Processing activities)
#=======================================================
locals {
  name-prefix = lower(var.name-prefix)
  null-triggers = {
    location          = var.location
    id-project        = var.id-project
    cidr-subnet       = google_compute_subnetwork.subnet-cluster.ip_cidr_range
    cluster-name      = module.gke-cluster.cluster.name
    cluster-sec-name  = module.gke-cluster.cluster.ip_allocation_policy[0]["cluster_secondary_range_name"]
    cluster-sec-range = module.gke-cluster.cluster.ip_allocation_policy[0]["cluster_ipv4_cidr_block"]
    cluster-srv-name  = module.gke-cluster.cluster.ip_allocation_policy[0]["services_secondary_range_name"]
    cluster-srv-range = module.gke-cluster.cluster.ip_allocation_policy[0]["services_ipv4_cidr_block"]
  }
}

#=======================================================
# Subnets
#=======================================================
resource "google_compute_subnetwork" "subnet-cluster" {
  name                     = "${local.name-prefix}${var.config-subnet-cluster.name-suffix}"
  project                  = var.id-project
  ip_cidr_range            = var.config-subnet-cluster.cidr
  region                   = var.location
  network                  = data.google_compute_network.vpc-cluster.self_link
  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name    = "${local.name-prefix}${var.config-gke-cluster.cluster-secondary-name-suffix}"
      ip_cidr_range = var.config-gke-cluster.cluster-secondary-range
    },
    {
      range_name    = "${local.name-prefix}${var.config-gke-cluster.cluster-service-name-suffix}"
      ip_cidr_range = var.config-gke-cluster.cluster-service-range
    }
  ]
}

#=======================================================
# GKE Cluster - Builds single cluster with variable 
#               number of node pools depending on tfvars
#=======================================================
module "gke-cluster" {
  source               = "app.terraform.io/Groupby/gkecluster/google"
  version              = "0.0.3"
  location             = var.location
  id-project           = var.id-project
  name-prefix          = var.name-prefix
  resource-labels      = var.resource-labels
  name-vpc-cluster     = data.google_compute_network.vpc-cluster.name
  name-subnet-cluster  = google_compute_subnetwork.subnet-cluster.name
  config-gke-cluster   = var.config-gke-cluster
  config-gke-nodepools = var.config-gke-nodepools
  depends_on           = [google_compute_subnetwork.subnet-cluster]
}
