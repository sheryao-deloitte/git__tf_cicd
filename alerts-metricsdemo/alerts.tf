#=======================================================
# Alerts
# > Default creates alerts for all clusters in
#   "name-all-clusters". To use a subset instead, use:
#   e.g. name-clusters-sysmetrics = {
#          cluster01 = "NameOfFirstCluster"
#          cluster02 = "NameOfSecondCluster"
#          ...
#        }
# > These modules create the alerts associated with this
#   cluster ONLY. The alerts can be grouped according to
#   any organizational structure (in this example,
#   "system" and "log" based alerts), and each module
#   creates alerts only for that grouping. GroupBy can
#   rearrange these groupings as desired and modify the
#   content of the modules accordingly.
#
#=======================================================
module "system-metrics-alerts" {
  source                   = "app.terraform.io/Groupby/clusteralerts/google"
  version                  = "0.0.4"
  notification-channels    = local.notification-channels
  name-client              = local.name-client
  name-clusters-sysmetrics = var.name-all-clusters
}

#module "log-based-metrics-alerts" {  //EXAMPLE
#  source                   = "../../modules/alerts_logs"
#  notification-channels    = local.notification-channels
#  name-client              = local.name-client
#  name-clusters-sysmetrics = var.name-all-clusters
#}
