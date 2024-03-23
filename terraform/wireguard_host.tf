data "digitalocean_ssh_key" "self" {
  name = "self"
}

resource "digitalocean_droplet" "wireguard_host" {
    image = "almalinux-9-x64"
    name = "wireguard"
    region = "ams3"
    size = "s-1vcpu-512mb-10gb"
    ssh_keys = [
      data.digitalocean_ssh_key.self.id
    ]
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "digitalocean_firewall" "wireguard" {
  name = "wireguard-firewall"
 
  droplet_ids = [digitalocean_droplet.wireguard_host.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${chomp(data.http.myip.response_body)}/32"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = ["0.0.0.0/0"]
  }
  
  inbound_rule {
    protocol         = "icmp"
    port_range       = "1-65535"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol         = "icmp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}

data "cloudflare_zone" "zone" {
  name = var.cloudflare_zone_id
}

resource "cloudflare_record" "in_a" {
  zone_id = data.cloudflare_zone.zone.id
  name    = var.wg_hostname
  value   = resource.digitalocean_droplet.wireguard_host.ipv4_address
  type    = "A"
  proxied = false
}
