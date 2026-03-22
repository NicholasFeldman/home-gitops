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
            version = "2024.12.1"
        }
        bitwarden = {
            source  = "maxlaverse/bitwarden"
            version = ">= 0.8.0"
        }
  }
}

provider "bitwarden" {
    email = "nick@feldman.tech"
}

data "bitwarden_item_secure_note" "authentik_token" {
    id = "a94b39aa-694e-4859-b691-b11301862179"
}

provider "authentik" {
    url = "https://authentik.feldman.tech"
    token = data.bitwarden_item_secure_note.authentik_token.notes
}
