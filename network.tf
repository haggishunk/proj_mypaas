# requisition a floating IP for each paas node
resource "digitalocean_floating_ip" "mypaas" {
  count      = "${var.instances}"
  droplet_id = "${element(digitalocean_droplet.mypaas.*.ipv4_address, count.index)}"
  region     = "${var.region}"
}

# set up the base domain A record for your PaaS
# defaults to first node
resource "digitalocean_domain" "mypaas" {
  name       = "${var.prefix}.${var.domain}"
  ip_address = "${digitalocean_floating_ip.mypaas.0.ip_address}"
}

# add a wildcard CNAME record to support appname subdomains
resource "digitalocean_record" "mypaas-wildcard" {
  domain = "${digitalocean_domain.mypaas.id}"
  type   = "CNAME"
  name   = "wildcard"
  value  = "*.${digitalocean_domain.mypaas.id}"
  ttl    = 600
}
