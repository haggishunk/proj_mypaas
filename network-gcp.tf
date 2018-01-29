# resource "google_dns_managed_zone" "mypaas" {
#   name     = "${var.gcp_dns_zone}"
#   dns_name = "${var.domain}."
# }

resource "google_dns_record_set" "mypaas" {
  name = "${var.prefix}.${var.domain}."
  type = "A"
  ttl = "300"

  managed_zone = "${var.gcp_dns_zone}"

  rrdatas = ["${digitalocean_floating_ip.mypaas.ip_address}"]
}

resource "google_dns_record_set" "wildcard" {
  name = "*.${var.prefix}.${var.domain}."
  type = "CNAME"
  ttl = "300"

  managed_zone = "${var.gcp_dns_zone}"

  rrdatas = ["${google_dns_record_set.mypaas.name}"]
}
