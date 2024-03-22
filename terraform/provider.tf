terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_api_key" {}
variable "do_pub_key" {}
variable "do_priv_key" {}
variable "wg_hostname" {}

provider "digitalocean" {
  token = var.do_api_key
}

data "digitalocean_ssh_key" "self" {
  name = "self"
}
