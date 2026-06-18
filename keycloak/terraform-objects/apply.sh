#!/bin/bash

rm -f terraform.tfstate
rm -rf .terraform*

terraform init
terraform apply -auto-approve