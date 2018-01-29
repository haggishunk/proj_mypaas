# MyPaaS:  A Simple Framework for Automating the Deployment of a Roll-Your-Own PaaS

This project uses terraform to provision a virtual machine and install Dokkuas a PaaS host.  I chose to use DigitalOcean for their cheap droplets/VMs and GoogleCloud's DNS for it's resilience.  This is by no means the only viable provider schema; I consciously used two different providers to play with a frankencloud model.

### Credentials

You will notice several references to credentials, most of which are specific to the cloud provider being used (ie. GCP, Digitalocean).  See [terraform's documentation](https://www.terraform.io/docs/providers/index.html) for help on accessing and working with your provider of choice.

### TLDR

1. Create a `terraform.tfvars` file to override some of the defaults set in `variables.tf`
  * `ssh_id:`  MD5 fingerprint of ssh key on DigitalOcean
  * `ssh_prikey:`  Specify the path to the ssh private key _(optional)_
  * `domain:`  Your TLD or subdomain thereof
  * `email:`  Your email, for Let's Encrypt
  * `region:`  The DigitalOcean region to deploy into _(optional)_
  * `size:`  The RAM of the droplet _(optional)_
  * `appname:`  name for app to be deployed _(optional)_
  * `gitname:`  source repo for app to be deployed _(optional)_
1. Save DigitalOcean token in `~/.creds/do_token`
1. Save Google Cloud json credential in `~/.creds/gcp_credentials.json`
1. Save Google Cloud project id in `~/.creds/gcp_project_id`

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

### More at

[blog.pantageo.us](http://blog.pantageo.us/deploying-my-very-own-paas.html)

### Next steps:

  * Allow any number of machines to be deployed
  * Segment machines by role
  * Add etcd interface
  * Develop a better app to deploy than the sample ruby app from [Heroku](https://github.com/heroku/ruby-rails-sample.git)
