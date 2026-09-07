resource "azurerm_monitor_data_collection_rule" "this" {
  name                = local.dcr_name
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    storage_blob {
      storage_account_id = var.storage_account_id
      container_name     = var.storage_container_name
      name               = "syslogDestination"
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["syslogDestination"]
  }

  data_sources {
    syslog {
      facility_names = ["auth", "authpriv", "cron", "daemon", "kern", "syslog", "user"]
      log_levels     = ["Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
      name           = "syslogDataSource"
      streams        = ["Microsoft-Syslog"]
    }
  }

  tags = local.common_tags

  depends_on = [azurerm_virtual_machine_extension.ama]
}