variable "app_service_plan_name" {
  description = "The app_service_plan_name of the application security group"
  type        = string
  default     = null
}
variable "DNS_DOMAIN" {
  description = "The default domain of the web apps"
  type        = string
  default     = "project.com"
}
variable "DNS_DOMAIN_AZURE" {
  description = "The default domain of the web apps"
  type        = string
  default     = "azurewebsites.net"
}
variable "DNS_RESOURCE_GROUP_NAME" {
  description = "The DNS_RESOURCE_GROUP_NAME of the web apps"
  type        = string
  default     = "DNS_Zone_RG"
}
variable "DOCKER_IMAGE" {
  description = "The DOCKER_IMAGE of the web app"
  type        = string
  default     = null
}
variable "DOCKER_IMAGE_TAGS" {
  description = "The DOCKER_IMAGE_TAGS of the web app"
  type        = string
  default     = "dev,demo,qa,test,www"
}
variable "DOCKER_NAME" {
  description = "The docker_name of the web app"
  type        = string
  default     = null
}
variable "DOCKER_PASSWORD" {
  description = "The docker_password of the web app"
  type        = string
  default     = null
}
variable "DOCKER_REGISTRY" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
variable "DOCKER_USERNAME" {
  description = "The DOCKER_USERNAME of the web app"
  type        = string
  default     = null
}
variable "ENVNAME" {
  description = "The ENVNAME of the web app"
  type        = string
  default     = null
}
variable "GIT_REPO" {
  description = "The GIT_REPO of the web app"
  type        = string
  default     = "https://IPAZDOTestRun@dev.azure.com/IPAZDOTestRun/IPAZDOTestRun/_git/vantage-ng-app"
}
variable "HOST" {
  description = "The HOST of the AppService Plan"
  type        = string
  default     = null
}
variable "HOSTNAME" {
  description = "The HOSTNAME of the AppService Plan"
  type        = string
  default     = null
}
variable "LOCATION" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "PREFIX" {
  description = "The prefix of the web app"
  type        = string
  default     = null
}
variable "RESOURCE_GROUP_NAME" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "sa_name" {
  description = "The name of the storageaccount"
  type        = string
  default     = null
}
variable "SUBSCRIPTION_ID" {
  description = "The subscription_id of the resource group"
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
