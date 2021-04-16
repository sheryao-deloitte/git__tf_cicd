# Terraform Deployment: Subnet + GKE Cluster

## Purpose
This Terraform deployment creates dashboards, alerts, services and their corresponding SLOs through various module calls. Information on how the module operates can be found in their associated README files. This deployment is designed to be run on Terraform Cloud only, as module source paths are tied to the Private Module Registry.

## Prerequisites
The following items should be set up prior to running this Terraform deployment:
+ GKE cluster names to be monitored
+ GCP notification channel display names available for input
+ (Terraform Cloud only) Terraform Cloud Workspace connected to this folder/branch/repository so that updates to this configuration is picked up by Terraform Cloud.

## Authentication
Credentials needed to run this deployment are instantiated and stored outside of this script for security reasons. The following methods can be used to authenticate to GCP prior to running Terraform commands:
+ Service Account credentials (local machine or Terraform Cloud use):
	1) Create a service account on GCP; give the service account the "Service Account Token Creator" role in addition to the other roles required for Terraform do deploy the necessary resources. GCS bucket access may also be needed for pipeline deployments if the state file is not managed by Terraform Cloud.
	2) Download the JSON key for this service account. On Terraform Cloud, copy the contents of the JSON file and store them in an environment variable named ```GOOGLE_CREDENTIALS``` for Terraform Cloud.

## Key files
+ alerts.tf - Calls one or more alert modules. Aside from cluster/client names and notification channels, all other settings for alerts are hardcoded into the module itself
+ dashboard.tf - Creates dashboards for each cluster based on JSON file (dashboard-config.json). Option available to create single dashboard instead. JSON must be modified according to required displayed metrics.
+ srv-SLOs.tf - Calls one more more service/SLOs modules according to application requirements. SLO configurations are hardcoded into the module for consistency.
+ deploy.auto.tfvars - Inputs for deployment. Entry of cluster names is manually done here to incorporate any potential clusters made outside of Terraform and for maximum modularity with existing infrastructure. Notification channels must be made prior to running this Terraform script, with the display names of relevant notification channels added here.
