.PHONY: default
default: init apply certificates ansible

.PHONY: init
init:
	terraform init terraform/

.PHONY: apply
apply:
	terraform apply terraform/
	$(MAKE) output

.PHONY: output
output:
	TF_CLI_ARGS="" terraform output -json | tee certificates/nodes.json
	tools/gen-kubeconfig.sh
	cp .terraform/hosts.conf ansible/hosts.conf

.PHONY: certificates
certificates:
	$(MAKE) -C certificates

.PHONY: ansible
ansible:
	cd ansible && ansible-playbook site.yml
