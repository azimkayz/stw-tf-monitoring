output "dcr_id" {
  value       = azurerm_monitor_data_collection_rule.this.id
  description = "The resource ID of the Data Collection Rule."
}

output "dcr_association_id" {
  value       = azurerm_monitor_data_collection_rule_association.this.id
  description = "The resource ID of the DCR-to-VM association — proof this requirement was satisfied."
}