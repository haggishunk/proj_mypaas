#!/usr/bin/bash

rm -rf ruby-rails-sample

terraform init
terraform plan

sleep 2

terraform apply

echo "Waiting for DNS record registration..."
sleep 60

sh app_pusher.sh
