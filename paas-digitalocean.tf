provider "digitalocean" {}

resource "digitalocean_droplet" "dokku" {
    image = "debian-9-x64"
    count = "${var.instances}"
    name = "${var.prefix}-${count.index+1}"
    region = "${var.region}"
    size = "${var.size}"
    backups = "False"
    ipv6 = "False"
    private_networking = "False"
    ssh_keys = ["${var.ssh_primo}"]

    provisioner "file" {
        source = "/home/n10/.ssh/id_rsa.pub"
        destination = "/root/.ssh/id_rsa.pub"
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("/home/n10/.ssh/id_rsa")}"
        }
    }

    provisioner "local-exec" {
        command = "wget -nv -O - https://raw.githubusercontent.com/haggishunk/proj_mypaas/master/bootstrap.sh | sh"
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file("/home/n10/.ssh/id_rsa")}"
        }
    }

}

output "msg" {
    value = "Your hosts are ready to go! Your hosts are: ${join(", ", digitalocean_droplet.dokku.*.ipv4_address)}"
}

output "ip" {
    value = "${digitalocean_droplet.dokku.0.ipv4_address}"
}
