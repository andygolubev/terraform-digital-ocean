data "digitalocean_domain" "this" {
  name = var.domain
}

resource "digitalocean_record" "service1" {
  domain = data.digitalocean_domain.this.id
  type   = "A"
  name   = var.service1-subdomain
  value  = data.digitalocean_loadbalancer.this.ip

  depends_on = [ local_file.get_load_balancer_script, ]
}

resource "digitalocean_record" "service2" {
  domain = data.digitalocean_domain.this.id
  type   = "A"
  name   = var.service2-subdomain
  value  = data.digitalocean_loadbalancer.this.ip

  depends_on = [ local_file.get_load_balancer_script, ]
}

resource "digitalocean_record" "service3" {
  domain = data.digitalocean_domain.this.id
  type   = "A"
  name   = var.service3-subdomain
  value  = data.digitalocean_loadbalancer.this.ip

  depends_on = [ local_file.get_load_balancer_script, ]
}

resource "digitalocean_record" "lb-workaround" {
  domain = data.digitalocean_domain.this.id
  type   = "A"
  name   = var.lb-workaround-subdomain
  value  = data.digitalocean_loadbalancer.this.ip

  depends_on = [ local_file.get_load_balancer_script, ]
}
