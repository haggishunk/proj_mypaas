# DigitalOcean vars

variable "instances" {
  type        = "string"
  description = "Number of droplets to deploy"
  default     = "1"
}

variable "prefix" {
  type        = "string"
  description = "Basename of droplets"
  default     = "whateveryoulike"
}

variable "region" {
  type        = "string"
  description = "DigitalOcean droplet region"
  default     = "sfo2"
}

variable "size" {
  type        = "string"
  description = "Droplet RAM"
  default     = "1GB"
}

variable "ssh_id" {
  # change this
  type        = "string"
  description = "SSH public key ID - MD5 hash works "
  default     = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
}

variable "ssh_prikey" {
  type        = "string"
  description = "Path to SSH private key"
  default     = "~/.ssh/id_rsa"
}

variable "appname" {
  type        = "string"
  description = "Name for Dokku app"
  default     = "helloclock"
}

variable "gitname" {
  type        = "string"
  description = "Git repo for app"
  default     = "heroku/ruby-rails-sample"
}

variable "domain" {
  # change this
  type        = "string"
  description = "The base domain for 'mypaas' subdomain"
  default     = "domain.tld"
}

variable "email" {
  # change this
  # note: unicode \u003C and \u003Efor angle brackets
  # note2:  may not need angle brackets!
  type = "string"

  description = "Email address for CSR to Let's Encrypt"
  default     = "person@domain.tld"
}
