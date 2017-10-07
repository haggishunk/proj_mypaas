#!/usr/bin/bash

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/tokain)"

terraform destroy
