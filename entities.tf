##############################################################################
#
# Author: Logan Mancuso
# Created: 07.30.2023
#
##############################################################################

resource "vault_identity_entity" "admin" {
  name = "admin"
  policies = [
    vault_policy.admin.name,
  ]
  metadata = {
    team = "admin"
  }
}

resource "vault_identity_group" "infra" {
  name = "infra"
  type = "internal"

  external_policies = true

  metadata = {
    version = "2"
  }
}

resource "vault_identity_group_policies" "infra" {
  policies = [
    vault_policy.shared.name,
    vault_policy.infra.name,
  ]
  exclusive = true
  group_id  = vault_identity_group.infra.id
}

resource "vault_identity_group" "app" {
  name = "app"
  type = "internal"

  external_policies = true

  metadata = {
    version = "2"
  }
}

resource "vault_identity_group_policies" "app" {
  policies = [
    vault_policy.shared.name,
    vault_policy.app.name,
  ]
  exclusive = true
  group_id  = vault_identity_group.app.id
}