variable "resource_group_name" {
  default = "myResourceGroup"
}

variable "resource_group_location" {
  type        = "string"
  default     = "East US"
  description = "This variable defines the…."
}

variable "resource_group_tag" {
  type        = "string"
  default     = "Production"
  description = "Production resource TAGS"
}

variable "vn_name" {
  type        = "string"
  default     = "myVnet"
  description = "This variable defines the virtual network name"
}

variable "vn_address_space" {
  type        = "list"
  default     = ["10.0.0.0/16"]
  description = "This is the default open network"
}

variable "vn_location" {
  type        = "string"
  default     = "East US"
  description = "This variable defines the virtual network location"
}

output "address" {
  value = "${azurerm_public_ip.myterraformpublicip.ip_address}"
}

variable "key_material" {
   description   = "name of the SSH key for Chef"
   default       = "ajennings"
}

variable "private_key" {
   description   = "I'm a private key"
}


/*variable "ARM_SUBSCRIPTION_ID" {
 
}
variable "ARM_CLIENT_ID" {
  
}
variable "ARM_CLIENT_SECRET" {
}
variable "ARM_TENANT_ID" {
 
}
*/

