#=======================================================
# Dashboard
# > Creates a dashboard defined in "dashboard-config.json" 
#   for EACH cluster
#=======================================================
resource "google_monitoring_dashboard" "dashboard-per-cluster" {
  for_each = var.name-all-clusters
  dashboard_json = templatefile(
    "./dashboard-config.json",
    {
      CLIENTNAME  = var.name-client,
      CLUSTERNAME = each.value
    }
  )
}

#=======================================================
# Use this dashboard resource instead if defining a 
# generic single dashboard. Variables for the template
# can be defined as desired, and entered into the 
# JSON template as "${SOMEVARIABLE}"
#=======================================================
#resource "google_monitoring_dashboard" "dashboard-single" {
#  dashboard_json = templatefile(
#    "./dashboard-config.json",
#    {
#      #SOMEVARIABLE = var.CUSTOMVARIABLE
#    }
#  )
#}
