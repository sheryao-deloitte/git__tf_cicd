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
location   = "us-east1"
id-project = "deloitte-labs"

resource-labels = {
  "client"      = "deloitte-test"
  "environment" = "prod"
}

config-subnet-cluster = {
  name-suffix = "-subnet"
  cidr        = "192.168.0.0/20"
}

config-gke-cluster = {
  name-suffix                   = "-cluster-public"
  cluster-secondary-name-suffix = "-pods"
  cluster-secondary-range       = "10.4.0.0/14"
  cluster-service-name-suffix   = "-services"
  cluster-service-range         = "10.0.32.0/20"
  k8s-master-version            = "1.17.14-gke.1600" # Use string "latest" here for latest version 
}

config-gke-nodepools = {
  nodepool01 = {
    name-suffix        = "-nodepool-01"
    preemptible        = "false"
    type-machine       = "n1-standard-1"
    type-disk          = "pd-standard"
    size-disk          = "100"
    node-count-initial = "1"
    k8s-node-version   = "1.17.14-gke.1600" #Use string "latest" here for latest version
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
