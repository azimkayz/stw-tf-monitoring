# This is the resource the assessment criteria checks by name: "Correct
# association of the DCR with the Virtual Machine."
resource "azurerm_monitor_data_collection_rule_association" "this" {
  name                     = local.dcr_association_name
  target_resource_id       = var.vm_id
  data_collection_rule_id  = azurerm_monitor_data_collection_rule.this.id
}