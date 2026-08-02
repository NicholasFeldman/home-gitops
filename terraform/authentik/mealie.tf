resource "authentik_provider_oauth2" "mealie-oauth2" {
    name = "Mealie - Oauth2"
    client_id = "mealie"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
    invalidation_flow = data.authentik_flow.default-provider-invalidation-flow.id

    allowed_redirect_uris = [
      {
        matching_mode = "strict"
        url           = "https://mealie.feldman.tech/login"
      },
    ]
    property_mappings = [
        data.authentik_property_mapping_provider_scope.scope-email.id,
        data.authentik_property_mapping_provider_scope.scope-profile.id,
        data.authentik_property_mapping_provider_scope.scope-openid.id,
    ]
    client_type = "confidential"
    signing_key = data.authentik_certificate_key_pair.generated.id
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
