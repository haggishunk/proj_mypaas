
output "msg_hosts" {
  value = "Your primary dokku host is: ${digitalocean_record.mypaas.fqdn} (${digitalocean_droplet.mypaas.0.ipv4_address})"
}

output "msg_apps" {
  value = "Your first application is deployed at: https://${var.appname}.${digitalocean_record.mypaas.fqdn}"
}
