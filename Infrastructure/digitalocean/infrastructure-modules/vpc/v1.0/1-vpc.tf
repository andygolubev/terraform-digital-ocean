resource "digitalocean_vpc" "this" {
  name     = var.vpc_name
  region   = var.digitalocean_region
  ip_range = var.vpc_cidr_block
}