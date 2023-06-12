# Brew + Terragrunt

Terraform provider upgrades doesn't always work on a mac because of missing hashes 
for `linux_amd64` or `darwin_arm64` however a Linux container with terragrunt can be 
used to upgrade the providers.

This Dockerfile creates a container with terragrunt and tfenv installed. It is
able to import the ssh keys and aws credentials from the host machine, by specifying
volumes for the .ssh and .aws directories. The container is also able to access the
terragrunt/terraform repo by specifying a volume for the current working directory.

### Requirements:
 * AWS credentials, optional a config file, in $HOME/.aws
 * SSH keys in $HOME/.ssh and a known passphrase, enter SSH passphrase when prompted
 * Run from the root of the terragrunt/terraform repo

### Build and run:
  ```
  docker build -t xylifyx/terragrunt -f scripts/Dockerfile .
  docker run -v $HOME/.ssh:/root/.ssh -v $HOME/.aws:/root/.aws -v $(pwd):/ws -w /ws -it xylifyx/terragrunt
  ```
### Terragrunt:
  ```
  cd /ws
  export AWS_PROFILE=profile
  terragrunt init
  terragrunt init -upgrade
  ```
### Update .terraform.lock.hcl for all platforms
  ```
  terragrunt providers lock -platform=darwin_amd64 -platform=darwin_arm64 -platform=linux_amd64 -platform=linux_arm64
  ```