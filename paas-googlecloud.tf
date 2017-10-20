# GCP provider data cached in env variables
provider "google" {
    credentials = "${file("~/.creds/gcp_credentials.json")}"
    project = "${chomp(file("~/.creds/gcp_project_id"))}"
    region = "${var.gcp_region}"
}

resource "google_dns_record_set" "mypaas" {
    name = "mypaas.${var.domain}."
    type = "A"
    ttl = 60

    managed_zone = "${var.gcp_dns_zone}"

    rrdatas = ["${digitalocean_droplet.mukku.0.ipv4_address}"]
}

resource "google_dns_record_set" "wildcard" {
    name = "*.mypaas.${var.domain}."
    type = "A"
    ttl = 60

    managed_zone = "${var.gcp_dns_zone}"

    rrdatas = ["${digitalocean_droplet.mukku.0.ipv4_address}"]
}
