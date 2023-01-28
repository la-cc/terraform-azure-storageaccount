output "account_id" {
  value = azurerm_storage_account.main.id
  description = "The ID of the Storage Account."
}

output "account_name" {
  value = azurerm_storage_account.main.name
  description = "The Name of the Storage Account."
}

output "primary_location" {
  value = azurerm_storage_account.main.primary_location
  description = "The Primary Location of the Storage Account."
}

output "primary_access_key" {
  value = azurerm_storage_account.main.primary_access_key
  description = "The Primary Access Key of the Storage Account."
}

output "container_ids" {
  value = tomap({
    for key, container in azurerm_storage_container.main : key => container.id
  })
  description = "A map of the IDs of the containers within the Storage Account."
}