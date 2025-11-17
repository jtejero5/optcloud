# Configurar proveedor 
provider "aws" {
    region = "us-east-1"
  
}

#Crear instancia de EC2
resource "aws_instance" "EC2_1" {
    instance_type = "t3.micro"
    ami = "ami-052064a798f08f0d3"

    tags = {
      Name = "terraform-EC2_1"
    }
  
}


provider "aws" {
    region = "us-east-1"
  
}

#Crear instancia de EC2
resource "aws_instance" "EC2_2" {
    instance_type = "t3.micro"
    ami = "ami-052064a798f08f0d3"

    tags = {
      Name = "terraform-EC2_2"
    }
  
}