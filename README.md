# Kubernetes the Terraform Way

This repository is used to implement and follow [kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way) but all sources will be created using Terraform or other automation tools.

## Deploying
- Use `make` in the root to deploy terraform
- Use `make` in `./certificates` to generate certificates

## Tools
- `terraform`: Using `0.11.14` as most linters/syntax/etc is still not working with `0.12`
- `direnv`

## Notes
- Ansible code could be optimized, but I tried to keep it "as is" while following the guide, only using as a tool not to do the steps on the console

## TODO
- [ ] Add CNAME or similar static DNS or IPs to LB
- [ ] Set `ansible/group_vars/workers.yml` dynamically
