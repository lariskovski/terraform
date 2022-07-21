variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
  default = false
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "vpc_security_group_ids" {
  type = list
}

variable "subnet_id" {
  type = string
}

variable "volume_type" {
  type = string
  default = "gp3"
}
