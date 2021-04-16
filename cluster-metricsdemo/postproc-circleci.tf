#=======================================================
# Variables - CircleCI curl Options
#=======================================================
variable "circleci-url" {
  default   = ""
  sensitive = true
}

variable "circleci-token" {
  default   = ""
  sensitive = true
}

#=======================================================
# CURL Trigger to CircleCI
#=======================================================
resource "null_resource" "curl" {
  provisioner "local-exec" {
    on_failure = fail
    command    = <<EOT
    curl --request POST  \
         --url ${var.circleci-url} \
	 --header 'Circle-Token: ${var.circleci-token}'  \
	 --header 'Content-Type: application/json'  \
	 --data '{"parameters": {"cluster_name": "${module.gke-cluster.cluster.name}","cluster_url": "http://${module.gke-cluster.cluster.endpoint}","project_id": "${var.id-project}","cluster_region": "${var.location}","cluster_env": "${var.cluster-env}","cluster_type": "primary","customer_group": "TBD","app_set": "${join(",", var.srv-list)}" }}'
    EOT
  }

  triggers = merge(local.null-triggers, { always-run = timestamp() })
}
