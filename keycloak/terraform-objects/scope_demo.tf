resource "keycloak_saml_client_scope" "demo_scope" {
  realm_id               = keycloak_realm.realm.id
  name                   = "demo_scope"
}

resource "keycloak_saml_user_property_protocol_mapper" "demoscope_lastname" {
  realm_id            = keycloak_realm.realm.id
  client_scope_id     = keycloak_saml_client_scope.demo_scope.id
  name                = "lastname"
  user_property              = "lastName"
  saml_attribute_name_format = "URI Reference"
  saml_attribute_name        = "urn:oid:2.5.4.4"
  friendly_name = "surname"
}

resource "keycloak_saml_user_property_protocol_mapper" "demoscope_firstname" {
  realm_id            = keycloak_realm.realm.id
  client_scope_id     = keycloak_saml_client_scope.demo_scope.id
  name                = "firstname"
  user_property              = "firstName"
  saml_attribute_name_format = "URI Reference"
  saml_attribute_name        = "urn:oid:2.5.4.42"
  friendly_name = "givenName"
}

resource "keycloak_saml_user_property_protocol_mapper" "demoscope_email" {
  realm_id            = keycloak_realm.realm.id
  client_scope_id     = keycloak_saml_client_scope.demo_scope.id
  name                = "email"
  user_property              = "email"
  saml_attribute_name_format = "URI Reference"
  saml_attribute_name        = "urn:oid:1.2.840.113549.1.9.1"
  friendly_name = "email"
}