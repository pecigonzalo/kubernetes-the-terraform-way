locals {
  controllers = [
    "ctrl-0 ansible_host=${module.ctrl-0.public_ip}",
    "ctrl-1 ansible_host=${module.ctrl-1.public_ip}",
    "ctrl-2 ansible_host=${module.ctrl-2.public_ip}",
  ]

  workers = [
    "wrkr-0 ansible_host=${module.wrkr-0.private_ip}",
    "wrkr-1 ansible_host=${module.wrkr-1.private_ip}",
    "wrkr-2 ansible_host=${module.wrkr-2.private_ip}",
  ]
}

data "template_file" "ansible_hosts" {
  template = "${file("${path.module}/templates/hosts.conf")}"

  vars {
    controllers = "${join("\n", local.controllers)}"
    workers     = "${join("\n", local.workers)}"
  }
}

resource "local_file" "foo" {
  content  = "${data.template_file.ansible_hosts.rendered}"
  filename = "${path.cwd}/.terraform/hosts.conf"
}
