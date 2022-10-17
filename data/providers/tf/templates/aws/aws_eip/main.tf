resource "aws_eip" "this" {
  count = var.nat_gateway_count > 0 ? var.nat_gateway_count : 0
  vpc   = true
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
  tags = merge(
    {
      "Name" = format(
        "%s-%s",
        var.name,
        element(var.azs, var.single_nat_gateway ? 0 : count.index),
      )
    },
    var.tags,
    var.tags_default,
  )
}