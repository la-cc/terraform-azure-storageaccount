resource "azurerm_storage_account" "main" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = data.azurerm_resource_group.main.name
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = var.account_kind
  access_tier                     = var.access_tier
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  enable_https_traffic_only       = var.enable_https_traffic_only
  min_tls_version                 = var.min_tls_version
  tags                            = var.tags
}

resource "azurerm_storage_container" "main" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = each.value
}

resource "azurerm_storage_share" "main" {
  for_each = var.file_shares

  name                 = each.key
  storage_account_name = azurerm_storage_account.main.name
  quota                = each.value
}

resource "azurerm_storage_account_network_rules" "main" {
  for_each = var.network_rules

  storage_account_id         = azurerm_storage_account.main.id
  default_action             = each.value.default_action
  ip_rules                   = each.value.ip_rules
  virtual_network_subnet_ids = each.value.virtual_network_subnet_ids
  bypass                     = each.value.bypass
}