##############################################################################
#
# Author: Logan Mancuso
# Created: 11.27.2023
#
##############################################################################

data "vault_policy_document" "admin" {
  rule {
    path         = "secrets/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "permit all on all"
  }
}

data "vault_policy_document" "shared" {
  rule {
    path         = "secrets/shared/*"
    capabilities = ["read", "list"]
    description  = "permit readonly on shared secrets"
  }
}

data "vault_policy_document" "infra" {
  rule {
    path         = "secrets/infra/*"
    capabilities = ["read", "list"]
    description  = "permit readonly on infra secrets"
  }
}

data "vault_policy_document" "app" {
  rule {
    path         = "secrets/app/*"
    capabilities = ["read", "list"]
    description  = "permit readonly on app secrets"
  }
}

resource "vault_policy" "admin" {
  name = "admin"
  policy = data.vault_policy_document.admin.hcl
}

resource "vault_policy" "shared" {
  name = "shared"
  policy = data.vault_policy_document.shared.hcl
}

resource "vault_policy" "infra" {
  name = "infra"
  policy = data.vault_policy_document.infra.hcl
}

resource "vault_policy" "app" {
  name = "app"
  policy = data.vault_policy_document.app.hcl
}
