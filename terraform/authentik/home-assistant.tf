resource "authentik_provider_ldap" "homeassistant-ldap" {
    name = "Home Assistant - LDAP"
    base_dn = "OU=homeassistant,DC=ldap,DC=feldman,DC=tech"
    bind_flow = data.authentik_flow.default-authentication-flow.id
}

resource "authentik_application" "homeassistant" {
    name = "Home Assistant - LDAP"
    slug = "homeassistant"
    protocol_provider = authentik_provider_ldap.homeassistant-ldap.id
}

resource "authentik_group" "homeassistant_users" {
  name    = "Home Assistant Users"
}
