provider "digitalocean" {
  token = var.do_api_key
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}