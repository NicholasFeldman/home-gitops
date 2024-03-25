resource "authentik_provider_oauth2" "mealie-oauth2" {
    name = "Mealie - Oauth2"
    client_id = "mealie"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id

    redirect_uris = [
      "https://mealie.feldman.tech/login",
    ]
    property_mappings = [
        data.authentik_scope_mapping.scope-email.id,
        data.authentik_scope_mapping.scope-profile.id,
        data.authentik_scope_mapping.scope-openid.id,
    ]
}

resource "authentik_application" "mealie" {
    name = "Mealie - Oauth2"
    slug = "mealie"
    protocol_provider = authentik_provider_oauth2.mealie-oauth2.id
}

resource "authentik_group" "mealie_admins" {
  name    = "Mealie Admins"
}

resource "authentik_group" "mealie_users" {
  name    = "Mealie Users"
}
