# Terraform Deployment: Subnet + GKE Cluster

## Purpose
This Terraform deployment creates a new subnet and calls on the ```gke-cluster``` module to create a new GKE cluster and associated node pools. Information on how the module operates can be found in their associated README files.

## Prerequisites
The following items should be set up prior to running this Terraform deployment:
+ GCP Virtual Private Network (VPC) should be online as a "landing zone"
+ GCP service account with provisioning permissions activated
+ (Terraform Cloud only) Terraform Cloud Workspace connected to this folder/branch/repository so that updates to this configuration is picked up by Terraform Cloud.
+ (Local machine only) Terraform state file storage in GCP (backend storage process detailed later) 

## Authentication
Credentials needed to run this deployment are instantiated and stored outside of this script for security reasons. The following methods can be used to authenticate to GCP prior to running Terraform commands:
+ User credentials (local machine use): 
	1) Run ```gcloud auth application-default login``` to set up user credentials in the terminal where Terraform commands will be run.
	2) Run ```gcloud auth list``` to check that the proper user credentials are set prior to running Terraform commands
+ Service Account credentials (local machine or Terraform Cloud use):
	1) Create a service account on GCP; give the service account the "Service Account Token Creator" role in addition to the other roles required for Terraform do deploy the necessary resources. GCS bucket access may also be needed for pipeline deployments if the state file is not managed by Terraform Cloud.
	2) Download the JSON key for this service account.
		a. If running Terraform locally, store this key locally and run ```gcloud auth activate-service-account --key-file /PTH/TO/SERVICEACCOUNTKEY.json```. Run ```gcloud auth list``` to ensure that the correct service account is set for default Terraform operations.
		b. If running Terraform Cloud, copy the contents of the JSON file and store them in an environment variable named ```GOOGLE_CREDENTIALS``` for Terraform Cloud. For CircleCI, c`opy the contents of the JSON file and store them in an environment variable with the name of your choice in CircleCI. Refer to this environment variable name in CircleCI configurations.


## Terraform State File Backend
_*Not necessary for Terraform Cloud_

Terraform state files by default will be written to the local directory from which Terraform is run. This is not recommended from a security standpoint, so backend storage must be declared. Options vary here, but Google Storage buckets are used here as an example.

The backend declaration portion of the Terraform deployment is run before all other Terraform functions, and as a result the contents of the block cannot contain interpolations (i.e. no variable calls, resource attribute references), so all declarations must be static. This limits the use of the ```terraform.tfvars``` file or assigned variable values in dynamically declaring the bucket name and the internal bucket path within which the state file can reside.
```
>> Backend Declaration; All static calls
terraform {
  required_version = ">= 0.14.0"
  backend "gcs" {
    bucket = "storage-bucket-name"
    prefix = "PATH/INSIDE/BUCKET/name"
  }
}
```
In order to maintain the modularity of the code, such static declarations of backend storage are eschewed in favour of declaring the backend parameters when Terraform is initialized. The code is sanitized of all backend references in the following manner:
```
>> Backend Declaration removed
terraform {
  required_version = ">= 0.14.0"
}
```
When the code is first run, the ```terraform init``` command is instead run with the following parameters:
```
terraform init \
  backend-config="bucket=storage-bucket-name"
  backend-config="prefix=PATH/INSIDE/BUCKET/name"
```
Pipelines will need to incorporate this addition to the ```terraform init``` command and tailor the bucket and prefix entries such that each deployment will land in a unique place inside the bucket. This must be unique for each pipeline/deployment to prevent the overwriting of Terraform states between deployments.
