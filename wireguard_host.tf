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
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.do_priv_key} -e 'do_pub_key=${var.do_pub_key}' -e "wg_hostname=${var.wg_hostname}" ansible/site.yaml"
  }
}
