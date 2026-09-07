terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

provider "azurerm" {
  features {}
}

module "monitoring" {
  source = "../../"

  project_name         = "projecta"
  environment          = "dev"
  resource_group_name  = "rg-projecta-dev-southafricanorth"

  # In a real deployment, these come from the vm-nic and storage-account
  # modules' outputs. Hardcoded here just so this example is self-contained.
  vm_id                    = "/subscriptions/<subscription-id>/resourceGroups/rg-projecta-dev-southafricanorth/providers/Microsoft.Compute/virtualMachines/vm-projecta-dev-southafricanorth"
  storage_account_id       = "/subscriptions/<subscription-id>/resourceGroups/rg-projecta-dev-southafricanorth/providers/Microsoft.Storage/storageAccounts/stprojectadevsouthafri"
  storage_container_name   = "syslog-data"
}

output "dcr_id" {
  value = module.monitoring.dcr_id
}

output "dcr_association_id" {
  value = module.monitoring.dcr_association_id
}