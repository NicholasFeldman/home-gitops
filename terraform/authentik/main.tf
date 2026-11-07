terraform {
    cloud {
        organization = "nicholasfeldman"

        workspaces {
          name = "homelab-authentik"
        }
    }

    required_providers {
        authentik = {
            source = "goauthentik/authentik"
            version = "2026.8.2"
        }
  }
}

// Set in secrets.auto.tfvars (gitignored), which Terraform loads automatically.
variable "authentik_token" {
    description = "authentik API token"
    type        = string
    sensitive   = true
}

provider "authentik" {
    url = "https://authentik.feldman.tech"
    token = var.authentik_token
}
