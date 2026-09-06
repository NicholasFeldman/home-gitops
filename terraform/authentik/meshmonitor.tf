resource "authentik_provider_oauth2" "meshmonitor-oauth2" {
    name = "MeshMonitor - Oauth2"
    client_id = "VO1NmjXQ1mlsp4IJYjWELNTSwZeBB50PWgv8qOwV"
    client_type = "confidential"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
    invalidation_flow = data.authentik_flow.default-provider-invalidation-flow.id

    allowed_redirect_uris = [
      {
        matching_mode = "strict"
        url           = "https://meshmonitor.feldman.in/api/auth/oidc/callback"
      }
    ]
    // authentik's default 'profile' mapping already emits the `groups` claim
    // that MeshMonitor maps to its admin role -- there is no separate groups scope
    property_mappings = [
        data.authentik_property_mapping_provider_scope.scope-email.id,
        data.authentik_property_mapping_provider_scope.scope-profile.id,
        data.authentik_property_mapping_provider_scope.scope-openid.id,
    ]
    signing_key = data.authentik_certificate_key_pair.generated.id
}

resource "authentik_application" "meshmonitor" {
    name = "MeshMonitor - Oauth2"
    slug = "meshmonitor"
    protocol_provider = authentik_provider_oauth2.meshmonitor-oauth2.id
}

resource "authentik_group" "meshmonitor_admins" {
  name    = "MeshMonitor Admins"
}

resource "authentik_group" "meshmonitor_users" {
  name    = "MeshMonitor Users"
}

output "meshmonitor_client_secret" {
  value     = authentik_provider_oauth2.meshmonitor-oauth2.client_secret
  sensitive = true
}
