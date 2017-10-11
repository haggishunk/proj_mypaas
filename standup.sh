#!/usr/bin/bash

export PAAS_DOMAIN="pantageo.us"

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/do_token)"

export GOOGLE_CREDENTIALS="$(cat ~/.creds/gcp_credentials.json)"
export GOOGLE_PROJECT="$(cat ~/.creds/gcp_project_id)"
export GOOGLE_REGION="us-west1"

rm -rf ruby-rails-sample

terraform init
terraform plan

sleep 2

terraform apply

echo "Waiting for DNS record registration..."
sleep 60

sh app_pusher.sh
