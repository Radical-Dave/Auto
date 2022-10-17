resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count      = var.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0
  vpc_id     = aws_vpc.this[0].id
  cidr_block = element(var.secondary_cidr_blocks, count.index)
}