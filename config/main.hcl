# Hashi Vault Custom Config #
disable_mlock     = true
ui                = true
log_level         = "Debug"
log_format        = "json"
api_addr          = "https://localhost:8200"
default_lease_ttl = "744h"
max_lease_ttl     = "768h"

storage "file" {
  path = "/mnt/vault-data"
}

listener "tcp" {
  address            = "0.0.0.0:8200"
  tls_disable        = false
  tls_cert_file      = "/etc/ssl/certs/cert-intranet.crt"
  tls_key_file       = "/etc/ssl/certs/privkey.pem"
  tls_client_ca_file = "/etc/ssl/certs/cert-authority.crt"
  tls_min_version    = "tls13"
}
