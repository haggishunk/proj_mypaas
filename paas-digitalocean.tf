# digital ocean provider data cached in env variables
provider "digitalocean" {
    token = "${chomp(file("~/.creds/do_token"))}"
}

resource "digitalocean_droplet" "dokku" {
    image = "debian-9-x64"
    count = "${var.instances}"
    name = "${var.prefix}-${count.index+1}"
    region = "${var.do_region}"
    size = "${var.size}"
    backups = "False"
    ipv6 = "False"
    private_networking = "False"
    ssh_keys = ["${var.ssh_id}"]

    # Place your SSH public key on the
    # remote machine to support the dokku setup
    provisioner "file" {
        source = "~/.ssh/id_rsa.pub"
        destination = "/root/.ssh/id_rsa.pub"
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }

    # Stick the bootstrap.sh onto the
    # remote machine to do the dokku setup
    provisioner "file" {
        source = "./bootstrap.sh"
        destination = "/root/bootstrap.sh"
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }
    
    # Update your remote VM and install dokku
    provisioner "remote-exec" {
        inline = ["sh /root/bootstrap.sh",
                  "dokku apps:create ${var.appname}",
                  "dokku plugin:install https://github.com/dokku/dokku-postgres.git",
                  "dokku postgres:create rails-database",
                  "dokku postgres:link rails-database ${var.appname}",
                  "dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git",
                  "dokku config:set --no-restart ${var.appname} DOKKU_LETSENCRYPT_EMAIL=${var.email}",
                  "dokku letsencrypt ${var.appname}"]
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }
 
#    *** This is currently handled via the app_pusher.sh script ***
#    # Push app to dokku server
#    provisioner "local-exec" {
#         command = <<EOT
#             git clone git@github.com:heroku/ruby-rails-sample.git; 
#             cd ruby-rails-sample;
#             git remote add dokku dokku@${digitalocean_droplet.dokku.0.ipv4_address}:${var.appname}.mypaas.${var.domain};
#             git push dokku master
#         EOT
#    }

}

output "msg_hosts" {
    value = "Your are ready to go! Your dokku host is: ${join(", ", digitalocean_droplet.dokku.*.ipv4_address)}"
}

output "msg_apps" {
    value = "Your first application is deployed at: ${var.appname}.mypaas.${var.domain}"
}
