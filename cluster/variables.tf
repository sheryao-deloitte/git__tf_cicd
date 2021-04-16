#=======================================================
# Variables - Project
#=======================================================
variable "location" {
  type        = string
  description = "GCP deployment location"
}

variable "id-project" {
  type        = string
  description = "ID of project"
}

variable "name-prefix" {
  type        = string
  description = "Name suffix (e.g. client name) for named resources; forced into lowercase"
}

variable "resource-labels" {
  type        = map(string)
  description = "Map of resource labels for cluster"
}

variable "cluster-env" {
  type        = string
  description = "Cluster deployment environment, passed into curl"
}

#=======================================================
# Variables - Networking
#=======================================================
variable "name-vpc" {
  type        = string
  description = "Name of VPC"
}

variable "config-subnet-cluster" {
  type        = map(string)
  description = "Map of GKE subnet configurations"
}

#=======================================================
# Variables - GKE                                  
#=======================================================
variable "config-gke-cluster" {
  type        = map(string)
  description = "Map of GKE cluster configurations"
}

variable "config-gke-nodepools" {
  type        = map(map(string))
  description = "Map of GKE nodepools configurations"
}

variable "srv-list" {
  type        = list(any)
  description = "List of active services on this cluster"
}
