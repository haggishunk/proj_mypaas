
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
