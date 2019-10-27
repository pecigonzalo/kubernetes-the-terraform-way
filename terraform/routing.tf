locals {
  routes = [
    "10.200.0.0/24",
    "10.200.1.0/24",
    "10.200.2.0/24",
  ]

  instance_ids = [
    "${module.wrkr-0.id}",
    "${module.wrkr-1.id}",
    "${module.wrkr-2.id}",
  ]
}

resource "aws_route" "private-0-wrkr" {
  count = 3

  route_table_id         = "${module.dynamic_subnets.private_route_table_ids[0]}"
  instance_id            = "${local.instance_ids[count.index]}"
  destination_cidr_block = "${local.routes[count.index]}"
}

resource "aws_route" "private-1-wrkr" {
  count = 3

  route_table_id         = "${module.dynamic_subnets.private_route_table_ids[1]}"
  instance_id            = "${local.instance_ids[count.index]}"
  destination_cidr_block = "${local.routes[count.index]}"
}

resource "aws_route" "private-2-wrkr" {
  count = 3

  route_table_id         = "${module.dynamic_subnets.private_route_table_ids[2]}"
  instance_id            = "${local.instance_ids[count.index]}"
  destination_cidr_block = "${local.routes[count.index]}"
}

resource "aws_route" "public-wrkr" {
  count = 3

  route_table_id         = "${module.dynamic_subnets.public_route_table_ids[0]}"
  instance_id            = "${local.instance_ids[count.index]}"
  destination_cidr_block = "${local.routes[count.index]}"
}
