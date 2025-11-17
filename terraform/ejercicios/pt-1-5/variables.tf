variable "region" {
  description = "Regió AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nom del projecte"
  type        = string
  default     = "josept1.5"
}

variable "instance_count" {
  description = "Nombre d'instàncies per subnet"
  type        = number
  default     = 1
}

variable "subnet_count" {
  description = "Nombre de subxarxes per tipus"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Tipus d'instància EC2"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami" {
  description = "AMI d'Amazon Linux"
  type        = string
  default     = "ami-0cae6d6fe6048ca2c"
}

variable "create_s3_bucket" {
  description = "Crear bucket S3 si és true"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "my_ip" {
  description = "IP permesa per SSH"
  type        = string
  default     = "0.0.0.0/0"
}