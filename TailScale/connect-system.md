sudo apt update \
sudo apt install openssh-server
\ \
sudo systemctl enable ssh
sudo systemctl start ssh
\ \
sudo systemctl status ssh

**TailScale**

curl -fsSL https://tailscale.com/install.sh | sh
\
sudo tailscale up
\
tailscale ip -4
\
tailscale status
