
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id

  root_block_device {
    volume_type = var.volume_type
  }

}