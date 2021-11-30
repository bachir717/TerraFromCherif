provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:/Documents/TerraForm/Projet/DevOps/AWS/.aws/credentials"
}

#Appel du module  security-goup
module "security-goup" {
  source        = "../modules/security-goup"
  author = "app"

}

#Appel module de création du volume ebs
module "ebs" {
  source        = "../modules/ebs"
  dd_size = 5
  author = "app"
}

# Appel du module  ip pulique
module "ip_publique" {
  source        = "../modules/ip_publique"
}

# Appel du module  ec2
module "ec2" {
  source        = "../modules/ec2"
  author        = "app"
  instance_type = "t2.micro"
  sg_name= "${module.security-goup.out_security-goup_name}"
  public_ip = "${module.ip_publique.out_ip_publique_ip}"
  user = "ubuntu"
}


#creer les associations  entre les  ressources

resource "aws_eip_association" "ip_publique_assoc" {
  instance_id = module.ec2.out_instance_id
  allocation_id = module.ip_publique.out_ip_publique_id
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.out_vol_id
  instance_id = module.ec2.out_instance_id
}
