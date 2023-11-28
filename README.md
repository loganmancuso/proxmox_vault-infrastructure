# Terraform Proxmox

This workflow sets up a terraform state with secrets available to downstream workflows 

##### Depends on:
loganmancuso_infrastructure/applications/hashicorp-vault>

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


## Post Deploy
add the root cert as trusted on the local machine
```bash
openssl x509 -in ./keys/root/cert-authority.pem -inform PEM -out ./keys/root/cert-authority.crt
openssl x509 -in ./keys/client/cert-intranet.pem -inform PEM -out ./keys/client/cert-intranet.crt
sudo cp ./keys/root/cert-authority.crt /usr/local/share/ca-certificates/cert-authority.crt
sudo cp ./keys/client/cert-intranet.crt /usr/local/share/ca-certificates/cert-intranet.crt
sudo update-ca-certificates --fresh
```
add the unlock tokens to the proxmox.env for export variables, then resource it using `source proxmox.env`
```bash
export VAULT_ADDR='https://localhost:8200'
export VAULT_CAPATH=/usr/local/share/ca-certificates/cert-intranet.crt
export VAULT_DEV_ROOT_TOKEN_ID=hvs.XXXXXXXXXXXXXXXXXXXXXX
export UNSEAL_KEY_1=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
export UNSEAL_KEY_2=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
export UNSEAL_KEY_3=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```
