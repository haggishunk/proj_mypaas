# MyPaaS:  A Simple Framework for Automating the Deployment of a Roll-Your-Own PaaS

This project uses terraform to provision a virtual machine and install Dokkuas a PaaS host.  I chose to use DigitalOcean for their cheap droplets/VMs and GoogleCloud's DNS for it's resilience.  This is by no means the only viable provider schema; I consciously used two different providers to play with a frankencloud model.

### Credentials

You will notice several references to credentials, most of which are specific to the cloud provider being used (ie. GCP, Digitalocean).  See [terraform's documentation](https://www.terraform.io/docs/providers/index.html) for help on accessing and working with your provider of choice.

### TLDR

* edit `variables.tf` for ssh fingerprint, domain, email -- select region, size and number of droplets you need for the paas
* save DigitalOcean token in `~/.creds/do_token`
* save Google Cloud json credential in `~/.creds/gcp_credentials.json`
* save Google Cloud project id in `~/.creds/gcp_project_id`
* edit `paas-googlecloud.tf` for your DNS zone entries
* edit `paas-digitalocean.tf` if you'd like to use an ssh key other than the standard `.ssh/id_rsa`
* edit `bootstrap.sh` for your paas domain

### Init

After cloning this repository, initialize terraform plugins like so:
```
terraform init
```
You will have to do these each time you add new providers to the `.tf` files.

### Standup PaaS

Simply type:
```
terraform plan
```
to see what resources will be deployed.

This command sets it all in motion:
```
terraform apply
```

### Spin Down PaaS

This script merely runs `terrafrom destroy` to remove all traces of your deployment.
```
terrafom destroy
```

### More at

[blog.pantageo.us](http://blog.pantageo.us/deploying-my-very-own-paas.html)

### Next steps:

  * Allow any number of machines to be deployed
  * Segment machines by role
  * Add etcd interface
  * Add secondary script to push and deploy an application to Dokku host(s) - *DONE*
  * Develop a better app to deploy than the sample ruby app from [Heroku](https://github.com/heroku/ruby-rails-sample.git)
  * Add SSL support - *DONE*
