# GCP vars

variable "gcp_dns_zone" {
    # change this
    type = "string"
    description = "GCP DNS managed zone name"
    default = "yourzone"
}

variable "gcp_region" {
    type = "string"
    description = "GCP VM region selection"
    default = "us-west1"
}
