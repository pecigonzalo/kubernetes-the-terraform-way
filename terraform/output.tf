output "controller_public_ips" {
  value = {
    ctrl-0 = "${module.ctrl-0.public_ip}"
    ctrl-1 = "${module.ctrl-1.public_ip}"
    ctrl-2 = "${module.ctrl-2.public_ip}"
  }
}

output "controller_private_ips" {
  value = {
    ctrl-0 = "${module.ctrl-0.private_ip}"
    ctrl-1 = "${module.ctrl-1.private_ip}"
    ctrl-2 = "${module.ctrl-2.private_ip}"
  }
}

output "controller_public_dns_names" {
  value = {
    ctrl-0 = "${module.ctrl-0.public_dns}"
    ctrl-1 = "${module.ctrl-1.public_dns}"
    ctrl-2 = "${module.ctrl-2.public_dns}"
  }
}

output "worker_private_ips" {
  value = {
    wrkr-0 = "${module.wrkr-0.private_ip}"
    wrkr-1 = "${module.wrkr-1.private_ip}"
    wrkr-2 = "${module.wrkr-2.private_ip}"
  }
}

output "worker_private_dns_names" {
  value = {
    wrkr-0 = "${module.wrkr-0.private_dns}"
    wrkr-1 = "${module.wrkr-1.private_dns}"
    wrkr-2 = "${module.wrkr-2.private_dns}"
  }
}

output "lb_addresses" {
  value = "${aws_lb.kttw.dns_name}"
}
