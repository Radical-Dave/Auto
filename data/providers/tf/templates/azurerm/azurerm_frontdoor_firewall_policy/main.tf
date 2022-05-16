locals {
  name = replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0,63) : var.name) : "${replace(var.resource_group_name, " ","-")}-wafpolicy", "-", "")
}
resource "azurerm_frontdoor_firewall_policy" "this" {
  name = local.name
  resource_group_name = var.resource_group_name  
  enabled = var.enabled
  mode = var.mode
  #redirect_url = var.redirect_url
  custom_block_response_status_code = 403
  #custom_block_response_body = "403"
  tags = var.tags

  dynamic "custom_rule" {
    for_each = var.custom_rules
    content {
      name = custom_rule.value.name
      action = custom_rule.value.action
      type = custom_rule.value.type
      enabled = try(custom_rule.value.enabled, true)
      priority = custom_rule.value.priority
      rate_limit_duration_in_minutes = try(custom_rule.value.rate_limit_duration_in_minutes, 1)
      rate_limit_threshold = try(custom_rule.value.rate_limit_threshold, 10)
      dynamic "match_condition" {
        for_each = custom_rule.value.match_conditions
        content {
          match_variable = match_condition.value.match_variable
          match_values = match_condition.value.match_values
          operator = match_condition.value.operator
          #transforms = match_condition.value.transforms
        }
      }
    }
  }
  dynamic "managed_rule" {
    for_each = var.managed_rules
    content {
      type = managed_rule.value.type
      version = managed_rule.value.version    
      dynamic "exclusion" {
        for_each = managed_rule.value.exclusions
        content {
          match_variable = exclusion.value.match_variable
          operator = exclusion.value.operator
          selector = exclusion.value.selector
        }
      }
      #dynamic "managed_rule_set" {
      #  for_each = managed_rule.value.managed_rule_set
      #  content {
      #    rule_group_name = override.value.match_variable
      #    dynamic "exclusion" {
      #      for_each = override.value.exclusions
      #      content {
      #        match_variable = exclusion.value.match_variable
      #        operator = exclusion.value.operator
      #        selector = exclusion.value.selector
      #      }
      #    }
      #  }
      #}
    }
  }
}