locals {
  controllers = [
    "ctrl-0 ansible_host=${module.ctrl-0.public_ip}",
    "ctrl-1 ansible_host=${module.ctrl-1.public_ip}",
    "ctrl-2 ansible_host=${module.ctrl-2.public_ip}",
  ]

  workers = [
    "wrkr-0 ansible_host=${module.wrkr-0.private_ip} pod_cidr=10.200.0.0/24",
    "wrkr-1 ansible_host=${module.wrkr-1.private_ip} pod_cidr=10.200.1.0/24",
    "wrkr-2 ansible_host=${module.wrkr-2.private_ip} pod_cidr=10.200.2.0/24",
  ]
}

data "template_file" "ansible_hosts" {
  template = "${file("${path.module}/templates/hosts.conf")}"

  vars {
    controllers = "${join("\n", local.controllers)}"
    workers     = "${join("\n", local.workers)}"
  }
}

resource "local_file" "hosts" {
  content  = "${data.template_file.ansible_hosts.rendered}"
  filename = "${path.cwd}/.terraform/hosts.conf"
}
