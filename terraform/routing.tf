resource "aws_route" "wrkr-0" {
  route_table_id         = "${module.vpc.vpc_main_route_table_id}"
  instance_id            = "${module.wrkr-0.id}"
  destination_cidr_block = "10.200.0.0/24"
}

resource "aws_route" "wrkr-1" {
  route_table_id         = "${module.vpc.vpc_main_route_table_id}"
  instance_id            = "${module.wrkr-0.id}"
  destination_cidr_block = "10.200.1.0/24"
}

resource "aws_route" "wrkr-2" {
  route_table_id         = "${module.vpc.vpc_main_route_table_id}"
  instance_id            = "${module.wrkr-0.id}"
  destination_cidr_block = "10.200.2.0/24"
}
