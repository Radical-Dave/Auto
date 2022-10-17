resource "aws_instance" "this" {
  #count=var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  ami             = var.ami
  instance_type   = var.instance_type
  tags            = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
  security_groups = var.security_groups
}