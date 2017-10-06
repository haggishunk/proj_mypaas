#!/usr/bin/bash

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/tokain)"

terraform plan

sleep 2

terraform apply
