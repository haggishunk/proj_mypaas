#!/usr/bin/bash

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/tokain)"
echo $DIGITALOCEAN_TOKEN

terraform plan

sleep 2

terraform apply
