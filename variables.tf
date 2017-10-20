# DigitalOcean vars

variable "instances" {
  default = "1"
}

variable "prefix" {
  default = "mukku"
}

variable "do_region" {
  default = "sfo1"
}

variable "size" {
  default = "512MB"
}

variable "ssh_id" {
  # change this to your DO ssh key
  default = "e6:ca:15:84:e7:71:8e:df:91:b1:1c:ae:c8:76:41:7d"
}

variable "appname" {
  default = "helloclock"
}

# GCP vars

variable "gcp_dns_zone" {
  # change this to your GCP DNS zone
  default = "coffee"
}

variable "gcp_region" {
  default = "us-west1"
}


# Shared/misc  vars

variable "domain" {
  # change this to your domain name
  default = "enjoyingmy.coffee"
}

variable "email" {
  # change this to your email address
  # unicode for angle brackets
  default = "\u003Ctravis@pantageo.us\u003E"
}
