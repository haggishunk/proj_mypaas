# digital ocean provider data cached in env variables
provider "digitalocean" {}

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
    # remote machine for dokku setup
    provisioner "file" {
        source = "~/.ssh/id_rsa.pub"
        destination = "/root/.ssh/id_rsa.pub"
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }
    
    # Update your remote VM and install dokku
    provisioner "remote-exec" {
        inline = ["wget -nv -O - https://raw.githubusercontent.com/haggishunk/proj_mypaas/master/bootstrap.sh | bash"]
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }
 
    # Set up the app database on dokku server
    provisioner "remote-exec" {
        inline = ["dokku apps:create mypaas.${var.domain}",
                  "dokku plugin:install https://github.com/dokku/dokku-postgres.git",
                  "dokku postgres:create rails-database",
                  "dokku postgres:link rails-database mypaas.${var.domain}"]
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        } 
    }

#    # Push app to dokku server
#    provisioner "local-exec" {
#         command = <<EOT
#             git clone git@github.com:heroku/ruby-rails-sample.git; 
#             cd ruby-rails-sample;
#             git remote add dokku dokku@${digitalocean_droplet.dokku.0.ipv4_address}:mypaas.${var.domain};
#             git push dokku master
#         EOT
#    }

}

output "msg" {
    value = "Your hosts are ready to go! Your hosts are: ${join(", ", digitalocean_droplet.dokku.*.ipv4_address)}"
}

output "ip" {
    value = "${digitalocean_droplet.dokku.0.ipv4_address}"
}
