##############################################################################
#
# Author: Logan Mancuso
# Created: 07.30.2023
#
##############################################################################

# Vault Entities #
output "vault_admin_entity_id" {
  description = "ID of group admin"
  value = vault_identity_entity.admin.id
}

output "vault_infra_group_id" {
  description = "ID of group infra"
  value = vault_identity_group.infra.id
}

output "vault_app_group_id" {
  description = "ID of group app"
  value = vault_identity_group.app.id
}

# Vault Paths #
output "vault_shared_path" {
  description = "Hashi Vault Path to shared secrets"
  value = vault_mount.shared.path
}

output "vault_infra_path" {
  description = "Hashi Vault Path to infra secrets"
  value = vault_mount.infra.path
}

output "vault_app_path" {
  description = "Hashi Vault Path to app secrets"
  value = vault_mount.app.path
}