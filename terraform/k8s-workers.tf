locals {
  wrkr_root_volume_size = "200"
  wrkr_instance_type    = "t3.micro"
}

module "wrkr-0" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "wrkr-0"

  tags = {
    kttw     = "worker"
    pod-cidr = "10.200.0.0/24"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.private_subnet_ids[0]}"
  source_dest_check           = false
  associate_public_ip_address = false
  assign_eip_address          = false

  security_groups = ["${aws_security_group.k8s-internal.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.private_subnet_cidrs[0], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.wrkr_instance_type}"
  root_volume_size = "${local.wrkr_root_volume_size}"
}

module "wrkr-1" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "wrkr-1"

  tags = {
    kttw     = "worker"
    pod-cidr = "10.200.1.0/24"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.private_subnet_ids[1]}"
  source_dest_check           = false
  associate_public_ip_address = false
  assign_eip_address          = false

  security_groups = ["${aws_security_group.k8s-internal.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.private_subnet_cidrs[1], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.wrkr_instance_type}"
  root_volume_size = "${local.wrkr_root_volume_size}"
}

module "wrkr-2" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=0.10.0"

  namespace = "${local.namespace}"
  stage     = "${local.stage}"
  name      = "wrkr-2"

  tags = {
    kttw     = "worker"
    pod-cidr = "10.200.2.0/24"
  }

  ami       = "${local.ami}"
  ami_owner = "${local.ami_owner}"

  vpc_id                      = "${module.vpc.vpc_id}"
  subnet                      = "${module.dynamic_subnets.private_subnet_ids[2]}"
  source_dest_check           = false
  associate_public_ip_address = false
  assign_eip_address          = false

  security_groups = ["${aws_security_group.k8s-internal.id}"]
  private_ip      = "${cidrhost(module.dynamic_subnets.private_subnet_cidrs[2], 10)}"

  ssh_key_pair     = "${var.ssh_key_pair}"
  instance_type    = "${local.wrkr_instance_type}"
  root_volume_size = "${local.wrkr_root_volume_size}"
}
