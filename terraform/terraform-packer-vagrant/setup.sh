#!/bin/bash
echo "## SETTING AWS CREDENTIALS ##"
echo -n "Access Key ID: "
read ID

sed -i -e "s#id-key#${ID}#g" terraform-packer/1-versions.tf

echo -n "Secret Access Key: "
read SECRET

sed -i -e "s#secret-key#${SECRET}#g" terraform-packer/1-versions.tf

vagrant up