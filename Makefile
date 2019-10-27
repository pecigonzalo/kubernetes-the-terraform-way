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
