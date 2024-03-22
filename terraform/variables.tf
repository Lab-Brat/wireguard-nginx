variable "do_api_key" {
    description = "DigitalOcean API key"
    type        = string
}

variable "wg_hostname" {
    description = "Hostname for the Wireguard host"
    type        = string
}

variable "do_pub_key" {
    description = "Path to public SSH key"
    default     = "~/.ssh/self.pub"
    type        = string
}

variable "do_priv_key" {
    description = "Path to private SSH key"
    default     = "~/.ssh/self"
    type        = string
}
