resource "keycloak_saml_client" "demoapp1" {
  realm_id                        = keycloak_realm.realm.id
  name                            = "demoapp1"
  client_id                       = "http://demoapp1/"
  valid_redirect_uris             = [ "http://demoapp1/acs.jsp" ]
  client_signature_required       = false
  sign_documents                  = true
  # signature_algorithm             = "RSA_SHA256"
  sign_assertions                 = true
  encrypt_assertions              = true
  encryption_certificate          = "MIIElTCCAv2gAwIBAgIUdNaTo4f9R7Gbb0Us3W/SVDJW6CMwDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCQVIxDTALBgNVBAgMBENBQkExFTATBgNVBAcMDEJ1ZW5vcyBBaXJlczESMBAGA1UECgwJSWRlbnRpY3VtMREwDwYDVQQDDAhkZW1vYXBwMTAeFw0yNTAyMDkyMzA4MjVaFw0zNTAyMDkyMzA4MjVaMFoxCzAJBgNVBAYTAkFSMQ0wCwYDVQQIDARDQUJBMRUwEwYDVQQHDAxCdWVub3MgQWlyZXMxEjAQBgNVBAoMCUlkZW50aWN1bTERMA8GA1UEAwwIZGVtb2FwcDEwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQDI+ffTp7+bBe76OBNLHOEIOlvfsIif5BV1Q2fj5/EUef/motU5/qjYGBhAfjdu/UyZrG6tBDT9KN6kN5dAcX4ovuAPD7iZp5xUyJcYWbBOkL7/i19RlPKuVKKYTcQsVaBsOnvAhHouo90UerbD/596i1tpyKnBa6n2wgKHi3RC0Zw23DfFv7ASyb/Xh93w6WkbrThJN5iEo+6Nkv9NCDbmCPwxcU6W6U9Lge059XkmlrLBbOC6hdv4bmRt6F8RK1mOU8MogUxWre0y7RB4UQg1KP1LQgMu6LMfq44PLcJFNft2hgoBzSpUV7h/2za+ecWTCb9WL7xm7TQlPrR8KhqzmPZKYOs3mqmqLGWC4e0ysge2vOvsl6/NJtvHqePaBxmSFZaUQhF7YoOr6SkzxhbJL79+KOr58LYua2oj1LBLMC+l6Vs491bTGGxatuGqIYX3zbRKiAgY4TiZpKC9nIt8sz4ikyOQL+ELLk3DIPtY2ZNwQGleRDLsEGwtNtXcnQMCAwEAAaNTMFEwHQYDVR0OBBYEFNmATtxpPELt+t9Za+OGPzKZQ1FbMB8GA1UdIwQYMBaAFNmATtxpPELt+t9Za+OGPzKZQ1FbMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggGBAICkA+9eTPakvnjJoM3vUIlTurCtFYCmSgf62kUGw56Xwza9dtJ0e4P1ZIDvQoN/AO2GKsyIYFmY1zz2yXaUwU3lHQ3a7GZPI6cWZn2UjPLKrtY/KCyN00qaaFr/44bTictsUVoUPpS931xJucpKGgQ+DXNyCtdhCxW8SoyPKbHIc3WrjeYz1lfp8GV+TyGsRu/bwLHRcxHETd46BqYbavEX7SiBTscm++iw9+RzSFgrpwtGXH0gOW8FgNhLHyF/ngFUXRyXmaoxDnaWLnGO4a4QKXulqY6jpTt7YIau7dsOIbyjJQfn/kes/BWyhCyTgN5ntXcYBXsBmH4aComBWiA/SUY1IfAryV1/C3P9qhIvF4HYb4QVhbDiAiKKTnob6/wXWG013DSbsDmQW97zLCXPzlqMNqYh+hWJqdrHZCHJh8SAKpmpWhEjEtE9UieTWW8ihecjY+nxw/8vUH9rKJJaGiSw51E97cROwxKJKjXNpYn/5AQbsLqL5hY3fHhryw=="
  force_name_id_format            = true
  name_id_format                  = "email"
  full_scope_allowed              = false
 
  logout_service_post_binding_url     = "http://demoapp1/sls.jsp"
}

resource "keycloak_saml_client_default_scopes" "demoapp1" {
  realm_id       = keycloak_realm.realm.id
  client_id      = keycloak_saml_client.demoapp1.id
  default_scopes = [ keycloak_saml_client_scope.demo_scope.name ]
}