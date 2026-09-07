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