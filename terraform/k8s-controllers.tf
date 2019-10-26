locals {
  ctrl_root_volume_size = "200"
  ctrl_instance_type    = "t3.micro"
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

  security_groups = ["${aws_security_group.k8s-external.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[0], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
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

  security_groups = ["${aws_security_group.k8s-external.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[1], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
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

  security_groups = ["${aws_security_group.k8s-external.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.public_subnet_cidrs[2], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.ctrl_instance_type}"
  root_volume_size = "${local.ctrl_root_volume_size}"
}
