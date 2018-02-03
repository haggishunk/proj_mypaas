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

# null resource used to reconnect to droplet
# after DNS record has been written
# (domain records should be available once
# app push is complete)
resource "null_resource" "letsencrypt" {
  depends_on = [
    "digitalocean_record.mypaas", 
    "digitalocean_record.wildcard",
  ]

  # use this for remote connection 
  connection {
    host        = "${digitalocean_droplet.mypaas.0.ipv4_address}"
    type        = "ssh"
    user        = "root"
    private_key = "${file("${var.ssh_prikey}")}"
  }

  # Push app to dokku server
  provisioner "local-exec" {
    command = "sh app_pusher.sh ${var.prefix}.${var.domain} ${var.appname} ${var.gitname}"
  }

  # Configure let's encrypt plugin and request ssl cert for app
  provisioner "remote-exec" {
    inline = ["dokku config:set --no-restart ${var.appname} DOKKU_LETSENCRYPT_EMAIL=${var.email}",
      "dokku letsencrypt ${var.appname}",
    ]
  }
}

output "msg_hosts" {
  value = "Your primary dokku host is: ${digitalocean_record.mypaas.fqdn} (${digitalocean_droplet.mypaas.0.ipv4_address})"
}

output "msg_apps" {
  value = "Your first application is deployed at: https://${var.appname}.${digitalocean_record.mypaas.fqdn}"
}
