# update and install packages
sudo apt update \
&& sudo apt install -y awscli wget sudo python3 python3-pip

# install terraform
sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
&& sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
&& sudo apt-get update && sudo apt-get install terraform

# install ansible
#sudo python3 -m pip install --user ansible \
#&& sudo python3 -m pip install --user paramiko \
#&& sudo python3 -m pip install ansible \
#&& sudo apt install -y ansible

# install packer
sudo apt install -y packer

# run terraform
cd /vagrant/terraform-packer
packer build aws-amz.pkr.hcl
terraform init
terraform apply -auto-approve
