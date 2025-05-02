# Running tally of commands to execute which can't be done yet in nix/home-manager
current_ip4="47.230.203.109"
# sudo iptables -I INPUT -p udp --dport 1714:1764 -j ACCEPT
# sudo iptables -I INPUT -p tcp --dport 1714:1764 -j ACCEPT
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp
sudo ufw reload
