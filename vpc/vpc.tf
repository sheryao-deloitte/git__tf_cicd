
#=======================================================
# Data Sources
#=======================================================
#data "google_container_engine_versions" "gkeversion" {
#  location = var.location
#  project  = var.id-project
#}

#data "google_compute_network" "vpc-cluster" {
#  name = var.name-vpc
#}


# Create vpc with custom subnet
resource "google_compute_network" "demo-vpc" {
  name                    = var.name-vpc
  auto_create_subnetworks = false
}

#Create VPC with custom subnet
resource "google_compute_subnetwork" "demo-subnet" {
  name          = var.subnet-name
  ip_cidr_range = "10.2.0.0/16"
  region        = var.location
  network       = google_compute_network.demo-vpc.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "10.220.0.0/24"
  }
}

# Add a firewall rule to allow HTTP, SSH, RDP, and ICMP traffic on mynetwork
resource "google_compute_firewall" "demo-tfcloud-allow-http-ssh-rdp-icmp" {
  name    = "demo-tfcloud-allow-http-ssh-rdp-icmp"
  network = google_compute_network.demo-vpc.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
}


