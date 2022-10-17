variable "PREFIX" {
  description = "The prefix of the web app"
  type        = string
  default     = null
}
variable "ENVNAME" {
  description = "The env of the web app"
  type        = string
  default     = null
}
variable "subscription_id" {
  description = "The subscription_id of the resource group"
  type        = string
  default     = null
}
variable "RESOURCE_GROUP_NAME" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "LOCATION" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "acr_resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "registry_name" {
  description = "The registry_name of the resource group"
  type        = string
  default     = null
}
variable "webhooks" {
  description = "The webhooks of the resource group"
  type        = list(string)
  default     = null
}
variable "container_groups" {
  description = "The container_groups of the resource group"
  type        = list(string)
  default     = null
}
variable "VAULT_NAME" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = null
}
variable "VAULT_RESOURCE_GROUP" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "base-terraform-rg"
}
variable "APP_SP" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "azdevops"
}
variable "sku" {
  description = "The sku of app serviceprincipal of the resource group"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "The admin enabled of the container registry"
  type        = bool
  default     = true
}
variable "public_network_access_enabled" {
  description = "The public_network_access_enabled of app serviceprincipal of the resource group"
  type        = bool
  default     = true
}
variable "containers" {
  description = "The containers of the container group"
  type = list(object({
    name   = string
    image  = string
    cpu    = string
    memory = string
  }))
  default = []
}
variable "aks_default_node_pool" {
  description = "The plan of the log analytics solution"
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = bool
  })
  default = {
    name                = "aks"
    vm_size             = "Standard_DS2_v2"
    enable_auto_scaling = false
  }
}
variable "password_end_date" {
  description = "The relative duration or RFC3339 rotation timestamp after which the password expire"
  default     = null
}
variable "password_rotation_years" {
  description = "Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password_end_date and either one is specified and not the both"
  default     = 1
}
variable "password_rotation_days" {
  description = "Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation.Conflicts with `password_end_date`, `password_rotation_in_years` and either one must be specified, not all"
  default     = null
}
variable "client_id" {
  description = "The client_id of the aks"
  type        = string
  default     = null
}
variable "client_secret" {
  description = "The client_secret of the aks"
  type        = string
  default     = null
}
variable "aks_plan" {
  description = "The plan of the aks"
  type = object({
    publisher = string
    product   = string
    # promotion_code=string
  })
  default = {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAppGatewayAnalytics"
  }
}
variable "ssh_public_key" {
  description = "The ssh_public_key of the aks"
  type        = string
  default     = "~/.ssh/aks-default.pub"
}
variable "acr_name" {
  description = "The name of the container registry"
  type        = string
  default     = null
}
variable "keyvault_name" {
  description = "The name of the key vault"
  type        = string
  default     = "azcicd-key-vault"
}
variable "frontdoor_name" {
  description = "The name of the front door"
  type        = string
  default     = "azcicd-frontdoor"
}
variable "frontdoorwaf_name" {
  description = "The name of the front door waf policy"
  type        = string
  default     = "azcicd-frontdoorglobalwaf"
}
variable "sa_name" {
  description = "The name of the storage account"
  type        = string
  default     = "azcicdsa"
}
variable "containerregistry_name" {
  description = "The name of the container registry"
  type        = string
  default     = "azcicd-repo"
}
variable "container_registry_webhooks" {
  description = "Manages an Azure Container Registry Webhook"
  type = map(object({
    service_uri    = string
    actions        = list(string)
    status         = optional(string)
    scope          = string
    custom_headers = optional(map(string))
  }))
  default = {
    webappdevvantagecoreapi = {
      service_uri = "https://$dev-vantage-core-api:6w7DZY3bGnCduJRcX3MHojxHbcZN4Exd3rlsinnCg3sRqSQLar7JihLdbx0G@dev-vantage-core-api.scm.azurewebsites.net/docker/hook"
      actions     = ["push"]
      status      = "enabled"
      scope       = "vantage-core-api:latest"
      custom_headers = {
        "Content-Type" = "application/json"
      }
    }
    webappdevvantagengapp = {
      service_uri = "https://$dev-vantage-ng-app:eJ6MsltXHPELw2fAh3kgMhJBoosBXljbuCmJ5pf1G4NDeNSq1NBciF4plzL3@dev-vantage-ng-app.scm.azurewebsites.net/docker/hook"
      actions     = ["push"]
      status      = "enabled"
      scope       = "vantage-ng-app:latest"
      custom_headers = {
        "Content-Type" = "application/json"
      }
    }
    webappdevvantageadminapi = {
      service_uri = "https://$dev-vantage-admin-api:doXi7i9doaRtZJDp0j52khu4aeQmrZMRl4u95MpJyGxiDEzAN0vtGBizi829@dev-vantage-admin-api.scm.azurewebsites.net/docker/hook"
      actions     = ["push"]
      status      = "enabled"
      scope       = "vantage-admin-api:latest"
      custom_headers = {
        "Content-Type" = "application/json"
      }
    }
    webappdevvantageadminapp = {
      service_uri = "https://$dev-vantage-admin-app:J5GwxQzd7KsCTK7zKoZFDxvvuqNyGbzChxk6HZnjxfBf13Kf80vgH44nq70h@dev-vantage-admin-app.scm.azurewebsites.net/docker/hook"
      actions     = ["push"]
      status      = "enabled"
      scope       = "vantage-admin-app:latest"
      custom_headers = {
        "Content-Type" = "application/json"
      }
    }
  }
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}