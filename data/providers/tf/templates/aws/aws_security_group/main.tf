resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }
  tags = var.tags
}