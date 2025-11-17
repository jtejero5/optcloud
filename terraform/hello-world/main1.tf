provider "aws" {
    region = "us-east-1" 
}

#Crear VPC
resource "aws_vpc" "vpc_jose" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "vpc-jose"
  
}

#Crear Subnet
resource "aws_subnet" "subnet_A" {
    vpc_id = aws_vpc.vpc_jose.id
    cidr_block = "10.0.32.0/25"
    availability_zone = "us-east-1a"

    tags = {
      Name = "subnetA"
    }


resource "aws_subnet" "subnet_B" {
    vpc_id = aws_vpc.vpc_jose.id
    cidr_block = "10.0.30.0/23"
    availability_zone = "us-east-1a"

    tags = {
      Name = "subnetB"
    }
}

resource "aws_subnet" "subnet_C" {
    vpc_id = aws_vpc.vpc_jose.id
    cidr_block = "10.0.33.0/28"
    availability_zone = "us-east-1a"

    tags = {
      Name = "subnetC"
    }

}

    #Crear instancia
resource "aws_instance" "instancias_A"{
    ami = "ami-052064a798f08f0d3"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet_A.id
    tags =  {
      Name = "instanciaA-2"
    }
}
resource "aws_instance" "instancias_B"{
    ami = "ami-052064a798f08f0d3"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet_B.id
    tags =  {
      Name = "instanciaB-2"
    }

}
resource "aws_instance" "instancias_C" {
    ami = "ami-052064a798f08f0d3"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet_C.id

    tags =  {
      Name = "instanciaC-2"
    }
}