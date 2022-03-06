SHELL = /bin/bash
.SHELLFLAGS = -euo pipefail -c
all: create-s3 apply-terraform


.ONESHELL: create-s3
create-s3:
	clear
	echo "creating s3 backend..."
	@aws s3api create-bucket --bucket terraform-testproject-cloud1


.ONESHELL: apply-terraform
apply-terraform:
	echo "running terraform apply"
	@terraform apply -auto-approve
