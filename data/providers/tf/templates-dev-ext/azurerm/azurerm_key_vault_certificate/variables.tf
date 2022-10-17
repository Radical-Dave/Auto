variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "domain" {
  description = "The domain of the AppService Plan"
  type        = string
  default     = null
}
variable "defaultdomain" {
  description = "The defaultdomain of the AppService Plan"
  type        = string
  default     = null
}
variable "hostname" {
  description = "The hostname of the AppService Plan"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "key_vault_id" {
  description = "The key_vault_id of the virtual network"
  type        = string
}
variable "certificate" {
  description = "The name block used to Import an existing certificate."
  type = object({
    contents = string
    password = string
  })
  default = null
}
variable "certificate_policy" {
  description = "The certificate_policy  of the resource group"
  #type=map(map(any))
  # type=object({
  #   issuer_parameters={
  #     name=string
  #   }
  #   key_properties={
  #     exportable=bool
  #     key_size=number
  #     key_type=string
  #     reuse_key=bool
  #   }
  #   lifetime_action={
  #     action={ action_type=string }
  #     trigger={ days_before_expiry=number }
  #   }
  #   secret_properties={
  #     content_type=string
  #   }
  #   x509_certificate_properties={
  #     extended_key_usage=list(any)
  #     key_usage=list(string)
  #     subject_alternative_names={ dns_names=string}
  #     subject=string
  #     validity_in_months=number
  #   }
  # })
  # type= optional(object({
  #   issuer_parameters=optional(object({
  #     name=optional(string) # Self or Unknown
  #   }))

  #   key_properties=optional(object({
  #     curve=optional(string) # P-256, P-256K, P-384, and P-521
  #     exportable=optional(bool)
  #     key_size=optional(number)
  #     key_type=optional(string)
  #     reuse_key=optional(bool)
  #   }))

  #   lifetime_action=optional(object({
  #     action=object({
  #       action_type=string # AutoRenew and EmailContacts
  #     })

  #     trigger=object({
  #       days_before_expiry =number
  #       lifetime_percentage=number
  #     })
  #   }))

  #   secret_properties=optional(object({
  #     content_type=optional(string) # application/x-pkcs12 for a PFX or application/x-pem-file for a PEM
  #   }))

  #   x509_certificate_properties=optional(object({
  #     extended_key_usage=list(string)

  #     key_usage=list(string) # cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation

  #     subject=string

  #     subject_alternative_names=optional(object({
  #       emails=optional(list(string))
  #       dns_names=optional(list(string))
  #       upns=optional(list(string))
  #     }))

  #     validity_in_months=number
  #   }))
  # }))
  type = object({
    issuer_parameters = object({
      name = string # Self or Unknown
    })

    key_properties = object({
      curve      = string # P-256, P-256K, P-384, and P-521
      exportable = bool
      key_size   = number
      key_type   = string
      reuse_key  = bool
    })

    lifetime_action = object({
      action = object({
        action_type = string # AutoRenew and EmailContacts
      })

      trigger = object({
        days_before_expiry  = number
        lifetime_percentage = number
      })
    })

    secret_properties = object({
      content_type = string # application/x-pkcs12 for a PFX or application/x-pem-file for a PEM
    })

    x509_certificate_properties = object({
      extended_key_usage = list(string)

      key_usage = list(string) # cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation

      subject = string

      subject_alternative_names = object({
        emails    = list(string)
        dns_names = list(string)
        upns      = list(string)
      })

      validity_in_months = number
    })
  })
  default = null
  #   default={
  #     key_properties={
  #       exportable=true
  #       key_size  =2048
  #       key_type  ="RSA"
  #       reuse_key =true
  #     }
  #     lifetime_action={
  #       action={
  #         action_type="AutoRenew"
  #       }
  #       trigger={
  #         days_before_expiry=30
  #       }
  #     }
  #     secret_properties={
  #       content_type="application/x-pkcs12"
  #     }
  #     x509_certificate_properties={
  #       # Server Authentication=1.3.6.1.5.5.7.3.1
  #       # Client Authentication=1.3.6.1.5.5.7.3.2
  #       extended_key_usage=["1.3.6.1.5.5.7.3.1"]
  #       key_usage=[
  #         "cRLSign",
  #         "dataEncipherment",
  #         "digitalSignature",
  #         "keyAgreement",
  #         "keyCertSign",
  #         "keyEncipherment",
  #       ]
  #       subject_alternative_names={
  #         dns_names=["mysite1.com"]
  #       }
  #       subject           ="CN=mysite1.com"
  #       validity_in_months=12
  #     }
  #   }
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}