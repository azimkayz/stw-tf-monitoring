locals {
  dcr_name              = "dcr-${var.project_name}-${var.environment}-${var.location}"
  dcr_association_name  = "dcra-${var.project_name}-${var.environment}-${var.location}"
  ama_extension_name    = "ama-${var.project_name}-${var.environment}-${var.location}"

  common_tags = merge(
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "Qays"
    },
    var.tags
  )
}