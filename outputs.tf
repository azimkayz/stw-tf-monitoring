output "dcr_id" {
  value       = azurerm_monitor_data_collection_rule.this.id
  description = "The resource ID of the Data Collection Rule."
}

output "dcr_association_id" {
  value       = azurerm_monitor_data_collection_rule_association.this.id
  description = "The resource ID of the DCR-to-VM association — proof this requirement was satisfied."
}

output "role_assignment_id" {
  description = "Resource ID of the Storage Blob Data Contributor role assignment."
  value       = azurerm_role_assignment.ama_storage_writer.id
}