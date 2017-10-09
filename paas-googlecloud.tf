resource "google_dns_record_set" "frontend" {
    name = "frontend.${google_dns_managed_zone.bongo.dns_name}"
    type = "A"
    ttl = 60

    managed_zone = "${google_dns_managed_zone.bongo.name}"

    rrdatas = ["${digitalocean_droplet.dokku.0.ipv4_address}"]
}

resource "google_dns_managed_zone" "bongo" {
    name = "bongo"
    dns_name = "pantageo.us"
}

provider "google" {
    credentials = "${file("/home/n10/.creds/MyPaas-abe0fc29e5c3.json")}"
    project = "MyPaas"
    region = "us-central1"
}
