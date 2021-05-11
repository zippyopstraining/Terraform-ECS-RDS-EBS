variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "name" {
   default = "Hashout"
}


variable "bastion_ami" {
  default = {
    "us-west-2" = "ami-00f7c900d2e7133e1"
    }
}

variable "vpc" {
  default =  "10.1.0.0/16"
}

variable "public_subnet1" {
  default =  "10.1.1.0/24"
}

variable "public_subnet_zone" {
  default = "us-west-2a"
}

variable "private_subnet1" {
  default =  "10.1.2.0/24"
}

variable "private_subnet_zone1" {
  default = "us-west-2a"
}

variable "private_subnet2" {
  default =  "10.1.3.0/24"
}

variable "private_subnet_zone2" {
  default = "us-west-2b"
}


variable "fargate_cpu" {
  default = "256"
}

variable "fargate_memory" {
  default = "512"
}

variable "app_port" {
  default = "80"
}

variable "app_image" {
  default = "nginx_1"
}

variable "app_count" {
  default = "1"
}

variable "db_name" {
  default = "newhashout"
}

variable "db_user" {
  default = "hashout"
}

variable "db_pass" {
  default = "1008Q66gvK5VcZr"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_version" {
  default = "5.7"
}
