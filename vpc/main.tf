#=======================================================
terraform {
  required_version = ">= 0.14.0"
 #backend "gcs" {
 #   credentials = "terraform-deploy.json"
 #   bucket = "demo-tf-tfstate-storage"
 #   prefix = "demo/tfstate/demo01"
 # }
}

#=======================================================
# Provider
#=======================================================
provider "google" {
  version = "~> 3.0.0"
  credentials = "terraform-deploy.json"
  project = var.id-project
  region  = var.location
}
