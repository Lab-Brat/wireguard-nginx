terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }

    http = {
      source  = "hashicorp/http"
      version = " ~> 3.4.2 "
    }
  }
}
