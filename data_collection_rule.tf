resource "azurerm_monitor_data_collection_rule" "this" {
  name                = local.dcr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "Linux"

  data_sources {
    syslog {
      name           = "syslogDataSource"
      facility_names = var.syslog_facility_names
      log_levels     = var.syslog_log_levels
      streams        = ["Microsoft-Syslog"]
    }
  }

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "syslogDestination"
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["syslogDestination"]
  }

  tags = local.common_tags

  depends_on = [
    azurerm_virtual_machine_extension.ama
  ]
}