// JELLYFIN

resource "authentik_provider_ldap" "jellyfin-ldap" {
    name = "Jellyfin - LDAP"
    base_dn = "OU=jellyfin,DC=ldap,DC=feldman,DC=tech"
    bind_flow = data.authentik_flow.default-authentication-flow.id
    search_group = "e32d8adb-96ee-4e6f-b92b-2e294586b949"
}

resource "authentik_application" "jellyfin" {
    name = "Jellyfin - LDAP"
    slug = "jellyfin"
    protocol_provider = authentik_provider_ldap.jellyfin-ldap.id
}

resource "authentik_group" "jellyfin_users" {
  name    = "Jellyfin Users"
}

resource "authentik_group" "jellyfin_admins" {
  name    = "Jellyfin Admins"
}
