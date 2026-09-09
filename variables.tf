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

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource ID of the target Log Analytics Workspace (e.g., /subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/...)."
}

variable "syslog_facility_names" {
  type        = list(string)
  description = "Syslog facilities to collect."
  default     = ["auth", "authpriv", "cron", "daemon", "kern", "syslog", "user"]
}

variable "syslog_log_levels" {
  type        = list(string)
  description = "Syslog severity levels to collect."
  default     = ["Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to created resources."
}