# terraform-azurerm-monitoring-dcr

Creates an Azure Monitor Data Collection Rule (DCR) that streams Syslog from a VM to the centralized Storage Account, associates the DCR with the VM, and installs the Azure Monitor Linux Agent extension the DCR depends on to collect anything. This is deliberately a separate module from `vm-nic` — monitoring is applied *after* compute exists, not embedded into it, so the Security Team's controls can be changed, versioned, and rolled out independently of the compute layer.

> **Verify before applying**: the `storage_blob` destination block on `azurerm_monitor_data_collection_rule` is sensitive to the azurerm provider version. Confirm the exact schema against the provider version pinned in `providers.tf` before applying against a real subscription.

## Scope

**Creates**
- One `azurerm_monitor_data_collection_rule`, with a `syslog` data source and a `storage_blob` destination
- One `azurerm_monitor_data_collection_rule_association`, linking the DCR to the target VM
- One `azurerm_virtual_machine_extension` (`AzureMonitorLinuxAgent`), required on the VM for the DCR to actually collect and ship data

**Does not create**
- The Virtual Machine the DCR is associated with — owned by the `vm-nic` module, passed in as `vm_id`
- The Storage Account and container the data lands in — owned by the `storage-account` module, passed in as `storage_account_id` and `container_name`

## Usage

```hcl
module "monitoring" {
  source = "github.com/azimkayz/terraform-azurerm-monitoring-dcr?ref=v1.0.0"

  project_name          = "stw"
  environment           = "prod"
  location              = "southafricanorth"
  resource_group_name   = module.resource_group.resource_group_name
  vm_id                 = module.vm.vm_id
  storage_account_id    = module.storage_account.storage_account_id
  container_name        = module.storage_account.container_name
}
```

A minimal, runnable example is in [`examples/basic`](./examples/basic).

## Naming

Patterns:
- DCR: `dcr-<project_name>-<environment>-<location>`
- DCR association: `dcra-<project_name>-<environment>-<location>`
- Destination: `dest-<project_name>-<environment>-<location>`

Example: `dcr-stw-prod-southafricanorth`

`location` is validated to accept only `southafricanorth` — no other Azure region is permitted on this platform.

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `project_name` | `string` | Yes | – | Short project name used to build resource names. |
| `environment` | `string` | Yes | – | Environment name, e.g. `dev`, `test`, `prod`. |
| `location` | `string` | No | `"southafricanorth"` | Azure region. Validated to reject every value except `southafricanorth`. |
| `resource_group_name` | `string` | Yes | – | Resource group the DCR is deployed into. |
| `vm_id` | `string` | Yes | – | Resource ID of the VM to associate the DCR with and install the monitoring extension on (from the `vm-nic` module). |
| `storage_account_id` | `string` | Yes | – | Resource ID of the centralized Storage Account syslog data is streamed to (from the `storage-account` module). |
| `container_name` | `string` | Yes | – | Name of the storage container syslog data is streamed to (from the `storage-account` module). |
| `syslog_facility_names` | `list(string)` | No | `["auth", "authpriv", "cron", "daemon", "syslog"]` | Syslog facilities to collect. |
| `syslog_log_levels` | `list(string)` | No | `["Warning", "Error", "Critical", "Alert", "Emergency"]` | Syslog severity levels to collect. |
| `tags` | `map(string)` | No | `{}` | Common tags applied to the DCR. |

## Outputs

| Name | Description | Consumed by |
|---|---|---|
| `data_collection_rule_id` | Resource ID of the Data Collection Rule. | Not currently consumed by another module; available for extending the DCR (e.g. additional associations) outside this platform. |
| `data_collection_rule_association_id` | Resource ID of the DCR-to-VM association. | Not currently consumed by another module; useful for confirming/auditing the association exists. |
| `ama_extension_id` | Resource ID of the Azure Monitor Agent VM extension. | Not currently consumed by another module; useful for confirming the extension provisioned successfully. |

## Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.0` |
| azurerm provider | `~> 3.90` |

## Versioning

Only tagged releases are supported for consumption — always pin `?ref=vX.Y.Z` in the `source` argument. `main` is not a supported consumption target and may change without notice.
