terraform {
  required_version = ">=0.14"  
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
}