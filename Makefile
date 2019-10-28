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
	cp .terraform/hosts.conf ansible/hosts.conf
	echo \
	"ansible_ssh_common_args: \"-J ubuntu@$$(jq -r '.controller_public_ips.value["ctrl-0"]' certificates/nodes.json)\"" \
	> ansible/group_vars/workers.yml

.PHONY: certificates
certificates:
	$(MAKE) -C certificates
	tools/gen-kubeconfig.sh

.PHONY: ansible
ansible:
	cd ansible && ansible-playbook site.yml
