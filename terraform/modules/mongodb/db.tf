resource "azurerm_cosmosdb_account" "cosmo_account" {

  name                = var.cosmo_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
  
  )

  offer_type = var.offer_type
  
  default_identity_type = var.default_identity_type

  kind = var.kind

  public_network_access_enabled = var.public_network_access_enabled

  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services

  network_acl_bypass_ids = var.network_acl_bypass_for_azure_services ? var.network_acl_bypass_ids : []

  local_authentication_disabled = var.local_authentication_disabled

  ip_range_filter = var.ip_range_filter

  enable_automatic_failover = var.enabled_automatic_failover

dynamic "geo_location" {
  for_each = var.geo_location

  content {
    location          = geo_location.value.location
    failover_priority = geo_location.value.failover_priority
    zone_redundant    = lookup(geo_location.value, "zone_redundant", false)
  }
}

  # dynamic "consistency_policy" {
  #   for_each = var.consistency_policy

  #   content {
  #     consistency_level       = consistency_policy.value.consistency_level
  #     max_interval_in_seconds = consistency_policy.value.consistency_level == "BoundedStaleness" ? lookup(consistency_policy.value, "max_interval_in_seconds", 5) : null
  #     max_staleness_prefix    = consistency_policy.value.consistency_level == "BoundedStaleness" ? lookup(consistency_policy.value, "max_staleness_prefix", 100) : null
  #   }
  # }
  consistency_policy {
    # Use the single value from the variable
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }


  dynamic "capabilities" {
    for_each = length(var.capabilities) > 0 ? var.capabilities : []

    content {
      name = capabilities.value.name
    }
  }

  # dynamic "virtual_network_rule" {
  #   for_each = length(var.virtual_network_rule) > 0 ? var.virtual_network_rule : []

  #   content {
  #     id                                   = virtual_network_rule.value.id
  #     ignore_missing_vnet_service_endpoint = lookup(var.virtual_network_rule.value, "ignore_missing_vnet_service_endpoint", false)
  #   }
  # }

  dynamic "backup" {
    for_each = length(var.backup) > 0 ? var.backup : []

    content {
      type                = backup.value.type
      interval_in_minutes = lookup(backup.value, backup.value.interval_in_minutes, "120")
      retention_in_hours  = lookup(backup.value, backup.value.retention_in_hours, "8")
      storage_redundancy  = lookup(backup.value, backup.value.storage_redundancy, "Zone")
    }
  }

  dynamic "cors_rule" {
    for_each = length(var.cors_rule) > 0 ? var.cors_rule : []

    content {
      allowed_headers    = cors_rule.value.allowed_headers
      allowed_methods    = cors_rule.value.allowed_methods
      allowed_origins    = cors_rule.allowed_origins
      exposed_headers    = cors_rule.exposed_headers
      max_age_in_seconds = cors_rule.max_age_in_seconds
    }
  }

  # identity {
  #   type         = var.identity.type ? var.identity.type : "SystemAssigned"
  #   identity_ids = length(var.identity.identity_ids) > 0 ? var.identity.identity_ids : []
  # }

}

# resource "azurerm_cosmosdb_mongo_database" "example" {
#   name                = var.mongodb_name
#   resource_group_name = var.resource_group_name
#   account_name        = var.cosmo_account_name
#  // throughput          = var.throughput

# }
