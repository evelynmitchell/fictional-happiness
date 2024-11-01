# hosted

DigitalOcean 

ssh root@64.23.251.191
Welcome to Ubuntu 24.10 (GNU/Linux 6.11.0-9-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Nov  1 20:01:34 UTC 2024

  System load:  0.38              Processes:             113
  Usage of /:   2.3% of 76.45GB   Users logged in:       0
  Memory usage: 5%                IPv4 address for eth0: 64.23.251.191
  Swap usage:   0%                IPv4 address for eth0: 10.48.0.5

ssh -p 2222 username@server_ip

# Todo

[ ] change ssh port
```
Edit /etc/ssh/sshd_config:

   Port 2222  # Replace with your chosen port number
```

[ ] require key to login, disable pw login
```
Edit /etc/ssh/sshd_config:

   PubkeyAuthentication yes
   PasswordAuthentication no
```

[ ] install fail2ban
```
Install fail2ban:

   sudo apt-get install fail2ban
Configure fail2ban to monitor SSH:

   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   sudo nano /etc/fail2ban/jail.local
Enable the SSH jail:

   [sshd]
   enabled = true
   ```

[ ] firewall
```
Example using ufw (Uncomplicated Firewall):

   sudo ufw allow 2222/tcp  # Replace with your SSH port
   sudo ufw enable
   ```

[ ] rate limit ssh
```
Implement rate limiting: Use iptables to limit the number of SSH connection attempts from a single IP address.
Example:

   sudo iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --set --name SSH
   sudo iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 --rttl --name SSH -j DROP
   ```
[ ] setup 2fa on ssh 

[ ] update system regularly 

[ ] always ssh auth

[ ] setup tailscale for vpn

[ ] setup cron to LLM review logs
```
You are a skilled and diligent System Administrator responsible for managing this server. You can ask any questions you may have about the server. Your task is to review the system logs, identify any issues, and recommend solutions to address them.

Please pay close attention to the following areas:

- Security: Ensure that the server is secure and protected from unauthorized access.

- Performance: Identify any performance issues and recommend solutions to improve the server's performance.

- Reliability: Ensure that the server is reliable and stable.

- Monitoring: Recommend tools or strategies to monitor the server's performance and health.

- Backup: Recommend a backup strategy to ensure that data is protected and can be recovered in case of data loss.

- Updates: Ensure that the server is up-to-date with the latest security patches and software updates.

- Documentation: Review the existing documentation and recommend any improvements or additional information that should be included.

Please provide detailed explanations for your recommendations and any commands or configurations that need to be implemented.
```
