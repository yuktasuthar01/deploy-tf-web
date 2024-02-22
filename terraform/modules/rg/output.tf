output "name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the Azure Resource Group"
}

output "location" {
  value       = azurerm_resource_group.rg.location
  description = "The azure region where region is located"
}