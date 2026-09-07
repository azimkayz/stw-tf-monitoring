variable "project_name" {
  type        = string
  description = "Short project identifier used in resource naming, e.g. 'projecta'."
}

variable "environment" {
  type        = string
  description = "Environment name used in resource naming, e.g. 'dev', 'test', 'prod'."
}

variable "location" {
  type        = string
  default     = "southafricanorth"
  description = "Azure region to deploy into."

  validation {
    condition     = var.location == "southafricanorth"
    error_message = "Only 'southafricanorth' is permitted as the deployment region for this project."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy into."
}

variable "vm_id" {
  type        = string
  description = "Resource ID of the Virtual Machine to monitor. Comes from the vm-nic module's vm_id output."
}

variable "storage_account_id" {
  type        = string
  description = "Resource ID of the centralized Storage Account for Syslog data. Comes from the storage-account module's output."
}

variable "storage_container_name" {
  type        = string
  description = "Name of the storage container for Syslog blobs. Comes from the storage-account module's output."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to created resources."
}