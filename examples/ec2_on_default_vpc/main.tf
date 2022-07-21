
# Amazon Linux 2
data "aws_ami" "this" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]
}

data "aws_vpc" "default" {
  default = true
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id                      = data.aws_ami.this.id
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_instance_profile
  # instance_type               = "t2.medium"
  key_name = var.key_name

  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id

}