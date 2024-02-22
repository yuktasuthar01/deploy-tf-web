variable "resource_group_name" {
  description = "The name of the Azure Resource Group."
  type        = string

}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "managed_by" {
  type        = string
  default     = null
  description = "This is the ID of resources that manages the  Resource Group"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A map of tags for the resources"
}