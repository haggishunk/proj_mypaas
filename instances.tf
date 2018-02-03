resource "digitalocean_droplet" "mypaas" {
  image              = "debian-9-x64"
  count              = "${var.instances}"
  name               = "${var.prefix}-${count.index+1}"
  region             = "${var.region}"
  size               = "${var.size}"
  backups            = "False"
  ipv6               = "False"
  private_networking = "False"
  ssh_keys           = ["${var.ssh_id}"]

  # use this for remote connection
  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("${var.ssh_prikey}")}"
  }

  # Place your SSH public key on the
  # remote machine to support the dokku setup
  provisioner "file" {
    source      = "${var.ssh_prikey}.pub"
    destination = "/root/.ssh/id_rsa.pub"
  }

  # Stick the bootstrap.sh onto the
  # remote machine to do the dokku setup
  provisioner "file" {
    source      = "./bootstrap.sh"
    destination = "/root/bootstrap.sh"
  }

  # Update your remote VM and install dokku
  provisioner "remote-exec" {
    inline = ["sh /root/bootstrap.sh ${var.prefix}.${var.domain}",
      "dokku apps:create ${var.appname}",
      "dokku config:set ${var.appname} CURL_CONNECT_TIMEOUT=30 CURL_TIMEOUT=300",
      "dokku plugin:install https://github.com/dokku/dokku-postgres.git",
      "dokku postgres:create rails-database",
      "dokku postgres:link rails-database ${var.appname}",
      "dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git",
    ]
  }
}
