locals {
  namespace = "kttw"                  # Kubernetes The Terraform Way
  stage     = "dev"
  ami       = "ami-040a1551f9c9d11ad" # Ubuntu 18.04 LTS EBS
  ami_owner = "099720109477"          # Canonincal
}
