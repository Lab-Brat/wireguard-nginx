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

    connection {
      host = self.ipv4_address
      user = "root"
      type = "ssh"
      private_key = file(var.do_priv_key)
      timeout = "2m"
    }

    provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yaml ../ansible/site.yaml"
    } 
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

output "myip" {
  value = "${chomp(data.http.myip.response_body)}/32"
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
    port_range       = "51821"
    source_addresses = ["${chomp(data.http.myip.response_body)}/32"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = ["0.0.0.0/0"]
  }
}