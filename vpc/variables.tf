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


#=======================================================
# Variables - Networking
#=======================================================
variable "name-vpc" {
  type        = string
  description = "Name of VPC"
}

#variable "config-subnet-cluster" {
#  type        = map(string)
#  description = "Map of GKE subnet configurations"
#}

variable "subnet-name" {
  type        = string
  description = "Name of the Subnet"
}

