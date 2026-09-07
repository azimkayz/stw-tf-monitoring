# The Azure Monitor Agent (AMA) extension must be present on the VM before a
# Data Collection Rule can collect anything from it. Applied here, separately
# from the VM module, so monitoring stays a reusable, standalone concern —
# per the assignment's mandate that monitoring not be embedded into compute.
resource "azurerm_virtual_machine_extension" "ama" {
  name                       = local.ama_extension_name
  virtual_machine_id         = var.vm_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.29"
  auto_upgrade_minor_version = true

  tags = local.common_tags
}