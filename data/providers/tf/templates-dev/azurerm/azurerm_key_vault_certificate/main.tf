data "azurerm_client_config" "current" {}
locals {
  name          = length(var.name) > 0 ? var.name : "${var.resource_group_name}-kvc"
  defaultdomain = length(var.defaultdomain) > 0 ? var.defaultdomain : "azurewebsites.net"
  domain        = length(var.domain) > 0 ? var.domain : local.defaultdomain
  hostname      = length(var.hostname) > 0 ? var.hostname : "${var.resource_group_name}.${local.domain}"
}
resource "azurerm_key_vault_certificate" "this" {
  key_vault_id = var.key_vault_id
  name         = local.name
  tags         = var.tags
  dynamic "certificate" {
    for_each = var.certificate != null ? [true] : []
    content {
      contents = each.contents
      password = each.password
    }
  }
  dynamic "certificate_policy" {
    for_each = var.certificate_policy != null || var.certificate == null ? [true] : []
    content {
      issuer_parameters {
        name = try(certificate_policy.value["issuer_parameters"].name, "Self")
      }
      key_properties {
        # exportable=try(certificate_policy.key_properties.exportable,null)
        exportable = try(certificate_policy.value["key_properties"]["exportable"], true)
        key_size   = try(certificate_policy.key_properties.key_size, 2048)
        key_type   = try(certificate_policy.key_properties.key_type, "RSA")
        reuse_key  = try(certificate_policy.key_properties.reuse_key, true)
      }
      secret_properties {
        content_type = try(certificate_policy.value["secret_properties"].content_type, "application/x-pkcs12")
      }
      lifetime_action {
        action {
          action_type = try(certificate_policy.lifetime_action.lifetime_action.action.action_type, "AutoRenew")
        }
        trigger {
          days_before_expiry = try(certificate_policy.lifetime_action.lifetime_action.trigger.days_before_expiry, 30)
        }
      }
      x509_certificate_properties {
        # Server Authentication=1.3.6.1.5.5.7.3.1
        # Client Authentication=1.3.6.1.5.5.7.3.2
        extended_key_usage = ["1.3.6.1.5.5.7.3.1"]
        key_usage          = ["cRLSign", "dataEncipherment", "digitalSignature", "keyAgreement", "keyCertSign", "keyEncipherment", ]
        subject_alternative_names {
          dns_names = [local.hostname]
        }
        subject            = "CN=${local.hostname}"
        validity_in_months = 12
      }
    }
  }
}