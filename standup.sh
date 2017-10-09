#!/usr/bin/bash

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/tokain)"

export GOOGLE_CREDENTIALS="$(cat ~/.creds/MyPaas-abe0fc29e5c3.json)"
export GOOGLE_PROJECT="$(cat ~/.creds/gcp_project_id)"
export GOOGLE_REGION="us-west1"

terraform plan

sleep 2

terraform apply
