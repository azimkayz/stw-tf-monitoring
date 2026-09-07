# stw-tf-monitoring

Single-responsibility Terraform module implementing Stewardship's Security
Team mandate: every Virtual Machine must stream Syslog data to a centralized
Storage Account via Azure Monitor Data Collection Rules (DCR).

## Scope

Creates:

- An Azure Virtual Machine Extension (Azure Monitor Agent, Linux) on the target VM
- An Azure Monitor Data Collection Rule (DCR), streaming the `Microsoft-Syslog`
  data flow to a Storage Blob destination
- A Data Collection Rule Association, linking the DCR to the VM

Monitoring is applied **after** compute creation as a separate, reusable
concern — never embedded into the VM+NIC module itself, per the project's
design mandate.

## Dependency chain

This module has two separate upstream dependencies:

- `vm_id` — from `stw-tf-vm-nic`
- `storage_account_id` / `storage_container_name` — from `stw-tf-storage-account`

## Naming — worked example

project_name = "projecta", environment = "prod":


## Usage

```hcl
module "monitoring" {
  source = "github.com/azimkayz/stw-tf-monitoring?ref=v1.0.0"

  project_name             = "projecta"
  environment              = "prod"
  resource_group_name      = module.resource_group.resource_group_name
  vm_id                    = module.vm_nic.vm_id
  storage_account_id       = module.storage_account.storage_account_id
  storage_container_name   = module.storage_account.storage_container_name
}
```

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5.0 |
| azurerm   | ~> 5.4.0   |

## Inputs

| Name                     | Type        | Default          | Required | Description                       |
|--------------------------|-------------|------------------|----------|-------------------------------------|
| project_name             | string      | n/a              | yes      | Short project identifier for naming |
| environment              | string      | n/a              | yes      | Environment name for naming         |
| location                 | string      | southafricanorth | no       | Azure region (validated)            |
| resource_group_name      | string      | n/a              | yes      | Existing resource group             |
| vm_id                    | string      | n/a              | yes      | VM resource ID (from vm-nic module) |
| storage_account_id       | string      | n/a              | yes      | Storage Account resource ID (from storage-account module) |
| storage_container_name   | string      | n/a              | yes      | Container name for Syslog blobs (from storage-account module) |
| tags                     | map(string) | {}               | no       | Additional tags                     |

## Outputs

| Name                | Description                                       |
|---------------------|-------------------------------------------------------|
| dcr_id              | Resource ID of the Data Collection Rule                  |
| dcr_association_id  | Resource ID of the DCR-to-VM association                 |

## Versioning

Tagged `v1.0.0`. Consumers should pin to a tag, not a branch.