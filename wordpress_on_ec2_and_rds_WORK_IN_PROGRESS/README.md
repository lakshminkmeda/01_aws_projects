TO DO

- To complete adding RDS Module and connecting it with EC2 instance
- To setup and verify wordpress 






Overview

This project provisions a secure AWS environment using Terraform that demonstrates connectivity between an Amazon EC2 instance hosted in a public subnet and a MySQL Amazon RDS instance hosted in private subnets.

Prerequisites
- AWS cli installed and configured
- Terraform installed

Running the Configuration

- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply
- terraform destroy

Useful Commands

Display only the resource names being created (output un-JSON-ified)
- terraform plan -no-color | Select-String "^  #"     --> Windows machines
- terraform plan -no-color | grep "^  #"              --> Linux based machines