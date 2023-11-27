##############################################################################
#
# Author: Logan Mancuso
# Created: 11.27.2023
#
##############################################################################

resource "vault_audit" "test" {
  type  = "socket"
  path  = "app_socket"
  local = false

  options = {
    address     = "127.0.0.1:8200"
    socket_type = "tcp"
    description = "application x socket"
  }
}

resource "vault_mount" "shared" {
  path = "secrets/shared"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "Shared Secrets KV Version 2 secret engine mount"
}

resource "vault_mount" "infra" {
  path = "secrets/infra"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "Infra Secrets KV Version 2 secret engine mount"
}

resource "vault_mount" "app" {
  path = "secrets/app"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "App Secrets KV Version 2 secret engine mount"
}