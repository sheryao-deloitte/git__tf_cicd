#=======================================================
# Service Level Objectives - SLO
# > Each module will create the services (e.g. sayt) and
#   associated SLOs for each service according to
#   service category (i.e. Searchandiser, Wisdom)
# > List of services for each category and SLO options 
#   hardcoded into module. The only thing 
#   passed into the module is the name of the cluster.
# > Service/SLOs grouped according to "searchandizer" 
#   and "wisdom" categories for clarity. Both modules 
#   will create each of their associated services and 
#   SLOs.
#=======================================================
module "searchandiser-services-SLOs" {
  for_each     = var.name-all-clusters
  source       = "app.terraform.io/Groupby/searchservicesSLOs/google"
  version      = "0.0.3"
  name-cluster = each.value
}

#module "wisdom-services-SLOs" {
#  for_each     = var.name-all-clusters
#  source       = "../../modules/wisdom_services_SLOs"
#  name-cluster = each.value
#}
