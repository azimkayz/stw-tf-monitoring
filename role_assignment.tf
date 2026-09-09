# Grants the VM's managed identity permission to write blobs to the
# centralized Storage Account. Required for AMA to authenticate when
# shipping data directly to storage (kind = AgentDirectToStore) — without
# this, the agent has an identity but no permission to use it.
resource "azurerm_role_assignment" "ama_storage_writer" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.vm_identity_principal_id
}