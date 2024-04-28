data "authentik_flow" "default-authentication-flow" {
    slug = "default-authentication-flow"
}

data "authentik_flow" "default-provier-authorization-implicit-consent" {
    slug = "default-provider-authorization-implicit-consent"
}