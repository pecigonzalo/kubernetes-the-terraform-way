.PHONY: init
init:
	terraform init terraform/

.PHONY: apply
apply:
	terraform apply terraform/

.PHONY: output
output:
	TF_CLI_ARGS="" terraform output -json | tee certificates/nodes.json
