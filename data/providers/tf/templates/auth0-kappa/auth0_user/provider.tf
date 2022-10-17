terraform {
  required_version = ">=0.14"
  required_providers {
    auth0 = {
      source  = "alexkappa/auth0"
      version = "=0.22.0"
    }
  }
}