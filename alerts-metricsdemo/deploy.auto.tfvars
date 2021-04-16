#=======================================================
# Project (Host) Settings
# Declare the following variables into Terraform Cloud:
# > GOOGLE_CREDENTIALS (environment variable, sensitive)
#=======================================================
location              = "us-central1"
id-project            = "deloitte-labs"

name-client = "DeloitteTest"
name-all-clusters = {
  cluster01 = "demo-tf-metrics-cluster-public"
  cluster02 = "clientname-prod-cluster-public"
}

names-notification-channels = [
  "DeloitteTest Notification Channel 1",
  "DeloitteTest Notification Channel 2"
]

srvs-searchandiser = {
  srv1 = "search-demosrv01"
  srv2 = "search-demosrv02"
  srv3 = "search-demosrv03"
}
