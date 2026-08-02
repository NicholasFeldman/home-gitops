resource "authentik_provider_oauth2" "paperless-oauth2" {
    name = "Paperless - Oauth2"
    client_id = "qvIvngOLxh59FqXnmsGuPhpME0P7C8h5l9Jq5Fk2"
    client_type = "confidential"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
    invalidation_flow = data.authentik_flow.default-provider-invalidation-flow.id

    allowed_redirect_uris = [
      {
        matching_mode = "strict"
        url           = "https://paperless.feldman.in/accounts/oidc/authentik/login/callback/"
      }
    ]
    property_mappings = [
        data.authentik_property_mapping_provider_scope.scope-email.id,
        data.authentik_property_mapping_provider_scope.scope-profile.id,
        data.authentik_property_mapping_provider_scope.scope-openid.id,
    ]
    signing_key = data.authentik_certificate_key_pair.generated.id
}

resource "authentik_application" "paperless" {
    name = "Paperless - Oauth2"
    slug = "paperless"
    protocol_provider = authentik_provider_oauth2.paperless-oauth2.id
}

resource "authentik_group" "paperless_users" {
  name    = "Paperless Users"
}

output "paperless_client_secret" {
  value     = authentik_provider_oauth2.paperless-oauth2.client_secret
  sensitive = true
}
