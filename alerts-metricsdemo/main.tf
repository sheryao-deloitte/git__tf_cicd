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
  project     = var.id-project
  region      = var.location
}

#=======================================================
# Data Sources
#=======================================================
data "google_monitoring_notification_channel" "notifychannels" {
  count        = length(var.names-notification-channels)
  display_name = element(var.names-notification-channels, count.index)
}

#=======================================================
# Local Variables
#=======================================================
locals {
  name-client           = lower(var.name-client)
  notification-channels = data.google_monitoring_notification_channel.notifychannels.*.name
}
