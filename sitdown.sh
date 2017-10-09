#!/usr/bin/bash

export DIGITALOCEAN_TOKEN="$(cat ~/.creds/do_token)"

export GOOGLE_CREDENTIALS="$(cat ~/.creds/gcp_credentials.json)"
export GOOGLE_PROJECT="$(cat ~/.creds/gcp_project_id)"
export GOOGLE_REGION="us-west1"

terraform destroy
