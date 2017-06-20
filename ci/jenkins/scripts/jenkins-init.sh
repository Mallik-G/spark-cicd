#!/bin/bash

# volume setup
sudo vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
	pvcreate ${DEVICE}
	vgcreate data ${DEVICE}
	lvcreate --name volume1 -l 100%FREE data
	mkfs.ext4 /dev/data/volume1
fi
sudo mkdir -p /var/lib/jenkins
echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' | sudo tee --append /etc/fstab > /dev/null
sudo mount /var/lib/jenkins

# install jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee --append /etc/apt/sources.list > /dev/null

sudo apt-get update
sudo apt-get install -y unzip
sudo apt-get install -y jenkins

# install pip
sudo wget -q https://bootstrap.pypa.io/get-pip.py
sudo -H python3 get-pip.py
sudo rm -f get-pip.py
# install awscli
sudo pip install awscli


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl status docker
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu


# install terraform
cd /usr/local/bin
wget -q https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_linux_amd64.zip
unzip terraform_0.9.8_linux_amd64.zip
# install packer
wget -q https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip
unzip packer_1.0.0_linux_amd64.zip
# clean up
sudo apt-get clean
rm terraform_0.9.8_linux_amd64.zip
rm packer_1.0.0_linux_amd64.zip
