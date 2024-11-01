# terraform

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "server" {
  name   = "ubuntu-s-2vcpu-4gb-amd-sfo3-01"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-24-10-x64"
  region = "sfo3"

  ssh_keys = [var.ssh_key_id]

  connection {
    host        = self.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_key_path)
    port        = 22
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update && sudo apt-get upgrade -y",
      "sudo apt-get install fail2ban -y",
      "sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local",
      "sudo nano /etc/fail2ban/jail.local",
      "echo '[sshd]\nenabled = true' >> /etc/fail2ban/jail.local",
      "sudo systemctl restart fail2ban",
      "sudo ufw allow 2222/tcp",
      "sudo ufw enable",
      "sudo iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --set --name SSH",
      "sudo iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 --rttl --name SSH -j DROP",
      "sudo ufw allow ssh/tcp",
      "echo 'Port 2222' | sudo tee -a /etc/ssh/sshd_config",
      "sudo systemctl restart ssh",
      "sudo apt-get install cron -y",
      "echo '* * * * * root /path/to/llm_review_logs.sh' | sudo tee -a /etc/crontab",
    ]
  }
}

resource "digitalocean_firewall" "server" {
  name = "fictional-happiness-firewall"

  droplet_ids = [digitalocean_droplet.server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "2222"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
