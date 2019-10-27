module "lb_label" {
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.11.1"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "kttw"
}

resource "aws_eip" "lb" {
  vpc = true

  tags = "${module.lb_label.tags}"
}

resource "aws_lb" "kttw" {
  name = "${module.lb_label.id}"

  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"

  subnet_mapping {
    subnet_id     = "${module.dynamic_subnets.public_subnet_ids[0]}"
    allocation_id = "${aws_eip.lb.id}"
  }

  tags = "${module.lb_label.tags}"
}

resource "aws_lb_listener" "kttw" {
  load_balancer_arn = "${aws_lb.kttw.arn}"
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.controllers.arn}"
  }
}
