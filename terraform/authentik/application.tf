// SNIPEIT

resource "authentik_provider_ldap" "snipeit-ldap" {
    name = "SnipeIT - LDAP"
    base_dn = "OU=snipeit,DC=ldap,DC=feldman,DC=tech"
    bind_flow = data.authentik_flow.default-authentication-flow.id
    search_group = "e32d8adb-96ee-4e6f-b92b-2e294586b949"
}

resource "authentik_application" "snipeit" {
    name = "SnipeIT - LDAP"
    slug = "snipeit"
    protocol_provider = authentik_provider_ldap.snipeit-ldap.id
}

resource "authentik_group" "snipeit_users" {
  name    = "SnipeIT Users"
}

// Grocy

resource "authentik_provider_ldap" "grocy-ldap" {
    name = "Grocy - LDAP"
    base_dn = "OU=grocy,DC=ldap,DC=feldman,DC=tech"
    bind_flow = data.authentik_flow.default-authentication-flow.id
    search_group = "e32d8adb-96ee-4e6f-b92b-2e294586b949"
}

resource "authentik_application" "grocy" {
    name = "Grocy - LDAP"
    slug = "grocy"
    protocol_provider = authentik_provider_ldap.grocy-ldap.id
}

resource "authentik_group" "grocy_users" {
  name    = "Grocy Users"
}
