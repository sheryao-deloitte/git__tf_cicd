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

variable "name-client" {
  type        = string
  description = "Name of client"
}

variable "name-all-clusters" {
  type        = map(any)
  description = "Map of ALL cluster names"
}

#=======================================================
# Variables - Notifications
#=======================================================
variable "names-notification-channels" {
  type        = list(any)
  description = "List of Notification Channel Names"
}

#=======================================================
# Variables - SLO
#=======================================================
variable "srvs-searchandiser" {
  type        = map(any)
  description = "Map of Seachandiser services requiring SLO settings"
}
