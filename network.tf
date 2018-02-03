# UNCOMMENT IF YOU DO NOT ALREADY HAVE A DOMAIN IN DIGITALOCEAN
# set up the base domain A record for your PaaS
# defaults to first node
# resource "digitalocean_domain" "mypaas" {
#   name       = "${var.domain}"
#   ip_address = "${digitalocean_floating_ip.mypaas.0.ip_address}"
# }

# add an A record to your dokku host
resource "digitalocean_record" "mypaas" {
  name   = "${var.prefix}"
  type   = "A"
  domain = "${var.domain}"
  value  = "${digitalocean_droplet.mypaas.0.ipv4_address}"
  ttl    = 600
}

# add a wildcard CNAME record to support appname subdomains
resource "digitalocean_record" "wildcard" {
  name   = "*.${var.prefix}"
  type   = "CNAME"
  domain = "${var.domain}"
  value  = "${var.prefix}.${var.domain}."
  ttl    = 600
}
