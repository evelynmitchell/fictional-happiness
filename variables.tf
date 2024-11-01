variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "ssh_key_id" {
  description = "ID of the SSH key to use"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}