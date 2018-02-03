# MyPaaS:  A Simple Framework for Automating the Deployment of a Roll-Your-Own PaaS

### Credentials

You will notice several references to credentials, most of which are specific to the cloud provider being used (ie. GCP, Digitalocean).  See [terraform's documentation](https://www.terraform.io/docs/providers/index.html) for help on accessing and working with your provider of choice.

### TLDR

* Save DigitalOcean token in `~/.creds/do_token`
* Edit the `terraform.tfvars` and provide your own values

The values in this file overrides the defaults set in `variables.tf`

  * `ssh_id:`  fingerprint of ssh key on DigitalOcean
  * `ssh_prikey:`  Specify the path to the ssh private key _(optional)_
  * `domain:`  Your TLD or subdomain thereof
  * `email:`  Your email, for Let's Encrypt
  * `region:`  The DigitalOcean region to deploy into _(optional)_
  * `size:`  The RAM of the droplet _(optional)_
  * `appname:`  name for app to be deployed _(optional)_
  * `prefix:`  subdomain for paas
  * `gitname:`  source repo for app to be deployed _(optional)_

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

This command takes it all down.  No more charges to your account :)
```
terrafom destroy
```

### This is a fork of Travis's original work he shared

[blog.pantageo.us](http://blog.pantageo.us/deploying-my-very-own-paas.html)
