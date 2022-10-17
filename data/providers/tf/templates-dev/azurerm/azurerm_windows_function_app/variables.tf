variable "name" {
  description = "The name of the function app"
  type        = string
  default     = null
}
variable "ip_restriction" {
  description = "The ip_restriction of the App"
  type        = set(map(string))
  default     = null
}
# variable ip_restriction" {
#   description="The ip_restriction of the resource group"
#   type=set(object({
#     virtual_network_subnet_id=optional(string)
#     action=optional(string)
#     ip_address=optional(string)
#     name=optional(string)
#     description=optional(string)
#     priority=optional(number)
#     tag=optional(string)
#   }))
#   default=null
# }
variable "location" {
  description = "The location of the function app"
  type        = string
  default     = "eastus"
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "service_plan_id" {
  description = "The service_plan_id of the resource group"
  type        = string
  default     = null
}
variable "site_config" {
  description = "The site_config of the App"
  type        = object({})
  # type=object(
  #   {
  #     scm_type=string
  #     always_on=string
  #     linux_fx_version=string
  #     health_check_path=string
  #     ip_restriction=list({})
  #   }
  # )
  default = null
  # {
  #   site_config={
  #     scm_type="GIT"
  #     always_on="true"
  #     linux_fx_version="DOCKER|${var.docker_registry}/${var.docker_image}:latest"
  #     health_check_path="/health"
  #   }
  #  }
  #{"WEBSITE_DNS_SERVER"="168.63.129.16" "WEBSITE_VNET_ROUTE_ALL"="1"}
}
variable "source_control_repo" {
  description = "The source_control_repo of the resource group"
  type        = string
  default     = null
}
variable "source_control_repo_branch" {
  description = "The source_control_repo_branch of the resource group"
  type        = string
  default     = "master"
}
variable "storage_account_name" {
  description = "The storage_account_name of the resource group"
  type        = string
  default     = null
}
variable "virtual_network_subnet_id" {
  description = "The virtual_network_subnet_id of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}