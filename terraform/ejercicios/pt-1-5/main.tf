resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
    Project = var.project_name
  }
}

resource "aws_subnet" "public" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1${element(["a", "b"], count.index)}"
  tags = {
    Name    = "${var.project_name}-public-${count.index}"
    Project = var.project_name
  }
}

resource "aws_subnet" "private" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  availability_zone = "us-east-1${element(["a", "b"], count.index)}"
  tags = {
    Name    = "${var.project_name}-private-${count.index}"
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "main" {
  name        = "${var.project_name}-sg"
  description = "Seguretat EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH des de IP personal"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP des de qualsevol lloc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP nomes des de la VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Tot el transit sortint"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

resource "aws_instance" "public" {
  count         = var.subnet_count * var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public[count.index % var.subnet_count].id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name      = "vockey"

  tags = {
    Name    = "${var.project_name}-ec2-public-${count.index}"
    Project = var.project_name
  }
}

resource "aws_instance" "private" {
  count         = var.subnet_count * var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private[count.index % var.subnet_count].id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name      = "vockey"

  tags = {
    Name    = "${var.project_name}-ec2-private-${count.index}"
    Project = var.project_name
  }
}

resource "aws_s3_bucket" "optional" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = "${var.project_name}-bucket"
  tags = {
    Name    = "${var.project_name}-bucket"
    Project = var.project_name
  }
}