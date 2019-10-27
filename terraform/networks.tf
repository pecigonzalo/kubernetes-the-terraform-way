locals {
  cidr_block      = "10.240.0.0/16"
  pods_cidr_block = "10.200.0.0/16"
}

module "vpc" {
  source = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=0.4.2"

  namespace  = "${local.namespace}"
  stage      = "${local.stage}"
  name       = "k8s"
  cidr_block = "${local.cidr_block}"
}

module "dynamic_subnets" {
  source = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=0.12.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "k8s"

  max_subnet_count = 3

  availability_zones = [
    "${data.aws_availability_zones.available.names}",
  ]

  vpc_id     = "${module.vpc.vpc_id}"
  igw_id     = "${module.vpc.igw_id}"
  cidr_block = "${local.cidr_block}"
}

resource "aws_security_group" "k8s-internal" {
  name_prefix = "kttw-internal"
  description = "Allow all internal"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "${local.cidr_block}",
      "${local.pods_cidr_block}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "k8s-external" {
  name_prefix = "kttw-external"
  description = "Allow SSH,ICMP,HTTPS"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "k8s-lb" {
  name_prefix = "kttw-lb"
  description = "Allow LB traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 6443
    to_port   = 6443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
