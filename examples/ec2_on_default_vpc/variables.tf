variable "project_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "iam_instance_profile" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list
}

variable "subnet_id" {
  type = string
}