resource "authentik_provider_oauth2" "argocd-oauth2" {
    name = "ArgoCD - Oauth2"
    client_id = "argocd"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
    invalidation_flow = data.authentik_flow.default-provider-invalidation-flow.id

    allowed_redirect_uris = [
      {
        matching_mode = "strict"
        url           = "https://argocd.feldman.in/auth/callback"
      },
      {
        matching_mode = "strict"
        url           = "https://argocd.feldman.in/api/dex/callback"
      },
    ]
    property_mappings = [
        data.authentik_property_mapping_provider_scope.scope-email.id,
        data.authentik_property_mapping_provider_scope.scope-profile.id,
        data.authentik_property_mapping_provider_scope.scope-openid.id,
    ]
    signing_key = data.authentik_certificate_key_pair.generated.id
}

resource "authentik_application" "argocd" {
    name = "ArgoCD - Oauth2"
    slug = "argocd"
    protocol_provider = authentik_provider_oauth2.argocd-oauth2.id
}

resource "authentik_group" "argocd_admins" {
  name    = "ArgoCD Admins"
}

resource "authentik_group" "argocd_viewers" {
  name    = "ArgoCD Viewers"
}
