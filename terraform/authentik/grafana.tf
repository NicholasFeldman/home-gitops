resource "authentik_provider_oauth2" "grafana-oauth2" {
    name = "Grafana - Oauth2"
    client_id = "a744bb74a9882f0f08895d1514029be2"
    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
    invalidation_flow = data.authentik_flow.default-provider-invalidation-flow.id

    allowed_redirect_uris = [
      {
        matching_mode = "strict"
        url           = "https://grafana.feldman.in/login/generic_oauth"
      },
    ]
    property_mappings = [
        data.authentik_property_mapping_provider_scope.scope-email.id,
        data.authentik_property_mapping_provider_scope.scope-profile.id,
        data.authentik_property_mapping_provider_scope.scope-openid.id,
    ]
}

resource "authentik_application" "grafana" {
    name = "Grafana - Oauth2"
    slug = "grafana"
    protocol_provider = authentik_provider_oauth2.grafana-oauth2.id
}

resource "authentik_group" "grafana_admins" {
  name    = "Grafana Admins"
}

resource "authentik_group" "grafana_editors" {
  name    = "Grafana Editors"
}

resource "authentik_group" "grafana_viewers" {
  name    = "Grafana Viewers"
}
