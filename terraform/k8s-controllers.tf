locals {
  ctrl_root_volume_size = "200"
  ctrl_instance_type    = "t3.micro"
  ctrl_lb_protocol      = "TCP"
  ctrl_lb_port          = 6443
  ctrl_lb_vpc_id        = "${module.vpc.vpc_id}"
}

resource "random_id" "controllers_tg" {
  keepers {
    name     = "${module.lb_label.id}"
    protocol = "${local.ctrl_lb_protocol}"
    vpc_id   = "${local.ctrl_lb_vpc_id}"
  }

  byte_length = 2
}

resource "aws_lb_target_group" "controllers" {
  name     = "${module.lb_label.id}-${random_id.controllers_tg.hex}"
  port     = "${local.ctrl_lb_port}"
  protocol = "${local.ctrl_lb_protocol}"
  vpc_id   = "${module.vpc.vpc_id}"

  health_check {
    enabled  = true
    protocol = "HTTP"
    port     = 80
    path     = "/healthz"
  }

  stickiness {
    type    = "lb_cookie"
    enabled = false
  }

  tags = "${module.lb_label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

module "ctrl-0" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "ctrl-0"

  tags = {
    kttw = "controller"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.public_subnet_ids[0]}"
  source_dest_check           = false
  associate_public_ip_address = true
  assign_eip_address          = false

  security_groups = [
    "${aws_security_group.k8s-external.id}",
    "${aws_security_group.k8s-internal.id}",
  ]

  private_ip = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[0], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
}

resource "aws_lb_target_group_attachment" "ctrl-0" {
  target_group_arn = "${aws_lb_target_group.controllers.arn}"
  target_id        = "${module.ctrl-0.id}"
  port             = 6443
}

module "ctrl-1" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "ctrl-1"

  tags = {
    kttw = "controller"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.public_subnet_ids[1]}"
  source_dest_check           = false
  associate_public_ip_address = true
  assign_eip_address          = false

  security_groups = [
    "${aws_security_group.k8s-external.id}",
    "${aws_security_group.k8s-internal.id}",
  ]

  private_ip = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[1], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
}

resource "aws_lb_target_group_attachment" "ctrl-1" {
  target_group_arn = "${aws_lb_target_group.controllers.arn}"
  target_id        = "${module.ctrl-1.id}"
  port             = 6443
}

module "ctrl-2" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "ctrl-2"

  tags = {
    kttw = "controller"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.public_subnet_ids[2]}"
  source_dest_check           = false
  associate_public_ip_address = true
  assign_eip_address          = false

  security_groups = [
    "${aws_security_group.k8s-external.id}",
    "${aws_security_group.k8s-internal.id}",
  ]

  private_ip = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[2], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
}

resource "aws_lb_target_group_attachment" "ctrl-2" {
  target_group_arn = "${aws_lb_target_group.controllers.arn}"
  target_id        = "${module.ctrl-2.id}"
  port             = 6443
}
