# MyPaaS:  A Simple Framework for Automating the Deployment of a Roll-Your-Own PaaS

This project uses terraform to provision a virtual machine and install Dokkuas a PaaS host.  I chose to use DigitalOcean for their cheap droplets/VMs and GoogleCloud's DNS for it's resilience.  This is by no means the only viable provider schema; I consciously used two different providers to play with a frankencloud model.

### Credentials

You will notice several references to credentials, most of which are specific to the cloud provider being used (ie. GCP, Digitalocean).  See [terraform's documentation](https://www.terraform.io/docs/providers/index.html) for help on accessing and working with your provider of choice.

### TLDR
* in `variables.tf`, edit ssh fingerprint, select region, size and number of droplets you need for the paas
* save DO token in `~/.creds/tokain`
* save google json credential in `~/.creds/`
* edit `paas-googlecloud.tf` for your DNS zone entries
* edit `paas-digitalocean.tf` for your SSH key references both public fingerprint and private key

### Standup PaaS
```
sh standup.sh
```
### Sitdown PaaS
```
sh sitdown.sh
```

### more at
[the web blog](http://blog.pantageo.us/deploying-my-very-own-paas.html)

### Next steps:

  * Allow any number of machines to be deployed
  * Segment machines by role
  * Add secondary script to push and deploy an application to Dokku host(s)