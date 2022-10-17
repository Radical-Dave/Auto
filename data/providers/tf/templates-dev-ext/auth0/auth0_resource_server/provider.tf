terraform {
  required_version = ">=0.14"
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 0.36.0"
    }
  }
}