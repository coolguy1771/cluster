terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2021.9.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.6.3"
    }
  }

}
data "sops_file" "authentik_secrets" {
  source_file = "secret.sops.yaml"
}
provider "authentik" {
  url   = data.sops_file.authentik_secrets.data["authentik_url"]
  token = "foo-bar"
  # Optionally set insecure to ignore TLS Certificates
  # insecure = true
}

resource "authentik_tenant" "Black-Element" {
  domain         = "."
  default        = true
  branding_title = "Black Element Studio"
  branding_favicon = "https://github.com/coolguy1771/website/blob/main/images/BlackElement_Logo_Square512x.png?raw=true"
  branding_logo = "https://raw.githubusercontent.com/coolguy1771/website/main/images/BlackElementLogo4kWhite.svg"
}