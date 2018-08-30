#!/bin/bash


yum update

if [ $? == 0 ]

then 

             echo "THIS IS DEBIAN"

#installing nginx
             echo "installing nginx"
             sudo apt-get install nginx -y
             sudo systemctl start nginx
             sudo systemctl enable nginx
             sudo systemctl status nginx


cat <<EOT > vproapp

upstream vproapp {

 server app01.com:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT
		mv vproapp /etc/nginx/sites-available/vproapp

		rm -rf /etc/nginx/sites-enabled/default

		ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
                sudo systemctl restart nginx

#enable firewall

            echo "enable firewall"
            sudo ufw allow 80/tcp
            sudo ufw status numbered

else



           echo "THIS IS REDHAT"

#nginx installation
         
          echo "nginx installation"
          sudo yum update
          sudo yum install epel-release -y
          sudo yum install nginx -y
          sudo service nginx start
          sudo chkconfig nginx on
		

cat <<EOT > vproapp

upstream vproapp {

 server app01.com:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT

         sudo("cat /root/vproapp  > /etc/nginx/conf.d/vproapp.conf")



         sudo service nginx restart

fi
