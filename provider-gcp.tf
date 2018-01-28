provider "google" {
    credentials = "${file("~/.creds/gcp_credentials.json")}"
    project = "${file("~/.creds/gcp_project_id")}"
    region = "${var.gcp_region}"
}
