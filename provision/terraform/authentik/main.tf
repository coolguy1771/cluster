terraform {

  required_providers {
    required_providers {
      authentik = {
        source  = "goauthentik/authentik"
        version = "2021.9.2"
      }
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.6.3"
    }
  }
  data "sops_file" "authentik_secrets" {
    source_file = "secret.sops.yaml"
  }
}
provider "authentik" {
  url   = data.sops_file.cloudflare_secrets.data["authentik_url"]
  token = "foo-bar"
  # Optionally set insecure to ignore TLS Certificates
  # insecure = true
}