// authentik 2025.10 changed the default 'email' mapping to return email_verified = false.
// All users here are managed in authentik, so keep reporting their addresses as verified.
resource "authentik_property_mapping_provider_scope" "scope-email-verified" {
  name        = "OpenID 'email' (verified)"
  scope_name  = "email"
  description = "Email address, marked as verified"
  expression  = <<-EOT
    return {
        "email": request.user.email,
        "email_verified": True,
    }
  EOT
}

data "authentik_property_mapping_provider_scope" "scope-profile" {
  name = "authentik default OAuth Mapping: OpenID 'profile'"
}

data "authentik_property_mapping_provider_scope" "scope-openid" {
  name = "authentik default OAuth Mapping: OpenID 'openid'"
}
