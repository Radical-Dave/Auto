module "google_compute_network" {
  source = "../google_compute_network"
  #auto_create_subnetworks = var.auto_create_subnetworks
  #mtu                     = var.mtu
  name = "${var.name}-network"
  project = var.project
}
module "google_compute_subnetwork" {
  depends_on    = [module.google_compute_network]
  source        = "../google_compute_subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  name = "${var.name}-subnetwork"
  project       = var.project
  network_id    = module.google_compute_network.id
}
module "instance" {
  depends_on = [module.google_compute_subnetwork]
  source     = "../google_compute_instance"
  name = "${var.name}-instance"
  network_id = module.google_compute_subnetwork.id
  project    = var.project  
}

# module set_env {
#   depends_on = [module.aws_iam_access_key]
#   source="../../local/set_env"
#   files={"set_env.txt"="AWS_ACCESS_KEY_ID=${module.aws_iam_access_key.id},\nAWS_ACCESS_KEY_ID=${module.aws_iam_access_key.encrypted_secret},\nAWS_SECRET_ACCESS_KEY=${module.aws_iam_access_key.secret != null ? module.aws_iam_access_key.secret : ""}"} 
# }
