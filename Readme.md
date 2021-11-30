Quelques notion importante 

#Permet de déclarer un group de sécurité pour EC2, sans quoi il ne sera pas possible d'y accéder
  resource "aws_security_group" "my_security-group" {
  #Il est nécessaire de nommer le security group, mais optionnel de lui donner une description
  name        = "${var.author}-security-group"
  description = "Allow http and https inbound traffic"
  #vpc_id      = aws_vpc.main.id



  #Sert à définir une règle d'entrée: L'accès à tous les ports, vers tous les ports, tous 
  #protocoles, est possible depuis un certain bloc CIDR
   ingress {
    description      = "HTTP from all"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from all"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from all"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 #Sert à définir une règle de sortie: Il est possible de sortir vers n'importe où, tous protocoles
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


commandes 
- terraform apply
- terraform plan
- terraform destroy
terraform apply génère le même plan que terraform plan, mais nous demande ensuite confirmation pour déployer l’infrastructure. Lorsqu’on la lui donne, Terraform crée alors les ressources et nous donne le temps requis pour les mettre en place.
On peut ensuite  voir notre photo de chat sur le bucket, soit en visitant l’adresse donnée, soit en allant voir directement sur la console AWS.
- Lors de la création des ressources, Terraform créé un fichier terraform.tfstate, ce fichier traque l’intégralité des ressources gérées par Terraform
- Pour détruire le bucket  il faut simplement lancer la commande  terraform destroy