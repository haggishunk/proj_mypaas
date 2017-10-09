resource "google_dns_record_set" "frontend" {
    name = "frontend.pantageo.us."
    type = "A"
    ttl = 60

    managed_zone = "bongo"

    rrdatas = ["${digitalocean_droplet.dokku.0.ipv4_address}"]
}

provider "google" {
    credentials = "${file("~/.creds/MyPaas-abe0fc29e5c3.json")}"
    project = "${file("~/.creds/gcp_project_id")}"
    region = "us-central1"
}
