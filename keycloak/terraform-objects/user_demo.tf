resource "keycloak_user" "demo" {
  realm_id = keycloak_realm.realm.id
  username = "demo"
  enabled  = true
  email      = "demo@mail.com"
  first_name = "First"
  last_name  = "Last"
  email_verified = true

  initial_password {
    value     = "demo"
  }
}
