#!/usr/bin/env bash
# sets up your web servers for the deployment of web_static

# install nginx if not installed
if [ ! -x /usr/sbin/nginx ]
then
apt update -y
apt install -y nginx
fi

# creating required folders
mkdir -p /data /data/web_static/ /data/web_static/releases/ 
mkdir -p /data/web_static/shared/ /data/web_static/releases/test/

# dummy HTML
touch /data/web_static/releases/test/index.html
printf %s "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>
" >> /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/
sudo chmod -R 755 /data/

# nginx config
sudo sed -i '15 i \\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
service nginx restart
