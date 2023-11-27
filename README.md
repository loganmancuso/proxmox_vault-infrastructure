# Terraform Proxmox

This workflow sets up a terraform state with secrets available to downstream workflows 

## Vault Structure

path of secrets in the vault will follow the pattern below
/secrets/{shared,infra,app}/{key}

## Usage
to deploy this workflow link the environment tfvars folder to the root directory. 
```bash
  ln -s env/main.tf
  ln -s env/terraform.tfvars

  tofu init .
  tofu plan
  tofu apply
```
### Pre Deployment
copy the files from the datacenter infrastructure

```bash
openssl x509 -in ../datacenter-infrastructure/keys/root/cert-authority.pem -inform PEM -out ./keys/cert-authority.crt
cp ../datacenter-infrastructure/keys/client/privkey.pem ./keys/privkey.pem
openssl x509 -in ../datacenter-infrastructure/keys/client/cert-intranet.pem -inform PEM -out ./keys/cert-intranet.crt
```

### Initializing the vault
```bash
# Generate the Sealing keys
vault operator init -key-shares=6 -key-threshold=3
```

```bash
# Unlocking the exisiting vault
vault operator unseal $UNSEAL_KEY_1
vault operator unseal $UNSEAL_KEY_2
vault operator unseal $UNSEAL_KEY_3
vault login $VAULT_DEV_ROOT_TOKEN_ID
vault status -format=json
```