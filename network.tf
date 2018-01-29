# requisition a floating IP for each paas node
resource "digitalocean_floating_ip" "mypaas" {
  count      = "${var.instances}"
  droplet_id = "${element(digitalocean_droplet.mypaas.*.id, count.index)}"
  region     = "${var.region}"
}

# set up the base domain A record for your PaaS
# defaults to first node
# resource "digitalocean_domain" "mypaas" {
#   name       = "${var.domain}"
#   ip_address = "${digitalocean_floating_ip.mypaas.0.ip_address}"
# }

# # add an A record to your dokku host
# resource "digitalocean_record" "mypaas" {
#   name   = "mypaas"
#   type   = "A"
#   domain = "${digitalocean_domain.mypaas.id}"
#   value  = "${var.prefix}.${digitalocean_domain.mypaas.id}"
#   ttl    = 600
# }

# # add a wildcard CNAME record to support appname subdomains
# resource "digitalocean_record" "mypaas-wildcard" {
#   name   = "wildcard"
#   type   = "CNAME"
#   domain = "${digitalocean_domain.mypaas.id}"
#   value  = "*.${digitalocean_record.mypaas.fqdn}"
#   ttl    = 600
# }

# output "domain" {
#   value = "${digitalocean_domain.mypaas.id}"
# }
