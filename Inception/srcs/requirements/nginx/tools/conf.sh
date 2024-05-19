#!/usr/bin/env bash

mkdir /etc/nginx/certificates
openssl req -x509 -newkey rsa:2048 -days 365 -nodes -keyout /etc/nginx/certificates/key.pem -out /etc/nginx/certificates/cert.pem -subj /CN=localhost

echo "server {
        listen 443 ssl http2;
        server_name ooutabac.42.fr;

        root   /var/www/html/wordpress;
        index index.php index.html index.htm index.nginx-debian.html;

        ssl_protocols TLSv1.2;
        ssl_certificate  /etc/nginx/certificates/cert.pem;
        ssl_certificate_key  /etc/nginx/certificates/key.pem;" > /etc/nginx/sites-available/default;
echo '
        location / {
                try_files $uri $uri/ /index.php?$args =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass wordpress:9000;
        }
}' >> /etc/nginx/sites-available/default;

nginx -g "daemon off;"
