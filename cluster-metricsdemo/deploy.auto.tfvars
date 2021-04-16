#=======================================================
# Project (Host) Settings
# Declare the following variables into Terraform Cloud:
# > name-vpc (different VPCs for prod/dev)
# > name-profix (different naming scheme for prod/dev)
# > circleci-url (sensitive variable)
# > circleci-token (sensitive variable)
# > cluster-env (passed into curl command only)
# > GOOGLE_CREDENTIALS (environment variable, sensitive)
#=======================================================
location   = "us-central1"
id-project = "deloitte-labs"

resource-labels = {
  "client"      = "deloitte-test"
  "environment" = "prod"
}

config-subnet-cluster = {
  name-suffix = "-subnet"
  cidr        = "10.128.0.0/20"
}

config-gke-cluster = {
  name-suffix                   = "-cluster-public"
  cluster-secondary-name-suffix = "-pods"
  cluster-secondary-range       = "10.84.0.0/14"
  cluster-service-name-suffix   = "-services"
  cluster-service-range         = "10.88.0.0/20"
  k8s-master-version            = "1.16.15-gke.6000" # Use string "latest" here for latest version 
}

config-gke-nodepools = {
  nodepool01 = {
    name-suffix        = "-nodepool-01"
    preemptible        = "false"
    type-machine       = "e2-standard-2"
    type-disk          = "pd-standard"
    size-disk          = "100"
    node-count-initial = "1"
    k8s-node-version   = "1.16.15-gke.6000" #Use string "latest" here for latest version
  }
  #  nodepool02 = {
  #    name-suffix        = "-nodepool-02"
  #    preemptible        = "false"
  #    type-machine       = "n1-standard-1"
  #    type-disk          = "pd-standard"
  #    size-disk          = "100"
  #    node-count-initial = "1"
  #    k8s-node-version   = "latest"
  #  }
}

srv-list = [
  "sample",
  "ambassador"
]
