# TLDR
* in `variables.tf`, edit ssh fingerprint, select region, size and number of droplets you need for the paas
* save DO token in `~/.creds/tokain`
* save google json credential in `~/.creds/`
* edit `paas-googlecloud.tf` for your DNS zone entries
* edit `paas-digitalocean.tf` for your SSH key references both public fingerprint and private key

# Standup PaaS
```
sh standup.sh
```
# Sitdown PaaS
```
sh sitdown.sh
```

# more at
[the web blog](http://blog.pantageo.us/deploying-my-very-own-paas.html)
