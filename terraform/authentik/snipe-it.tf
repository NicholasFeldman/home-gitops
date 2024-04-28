# resource "authentik_provider_ldap" "snipe-it-ldap" {
#     name = "SnipeIT - LDAP"
#     base_dn = "OU=snipeit,DC=ldap,DC=feldman,DC=tech"
#     bind_flow = data.authentik_flow.default-authentication-flow.id
# }

# resource "authentik_application" "snipe-it" {
#     name = "SnipeIT - LDAP"
#     slug = "snipeit"
#     protocol_provider = authentik_provider_ldap.snipe-it-ldap.id
# }
