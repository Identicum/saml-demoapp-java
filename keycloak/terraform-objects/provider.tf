terraform {
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "= 5.1.1"
    }
  }
}

provider "keycloak" {
    url           = "http://idp:8080"
    client_id     = "admin-cli"
    username      = "admin"
    password      = "admin"
}