resource "authentik_outpost" "outpost" {
  name = "LDAP"
  type = "ldap"
  protocol_providers = [
    authentik_provider_ldap.snipeit-ldap.id,
    authentik_provider_ldap.homeassistant-ldap.id,
    authentik_provider_ldap.jellyfin-ldap.id
  ]
  service_connection = authentik_service_connection_kubernetes.local-kubernetes.id
}
