resource "authentik_provider_proxy" "homeassistant-proxy" {
    name = "Home Assistant - Proxy"
    internal_host = "https://home-assistant.feldman.tech"
    external_host = "https://home-assistant.feldman.tech"

    authorization_flow = data.authentik_flow.default-provier-authorization-implicit-consent.id
}

resource "authentik_application" "homeassistant" {
    name = "Home Assistant - proxy"
    slug = "homeassistant"
    protocol_provider = authentik_provider_proxy.homeassistant-proxy.id
}
