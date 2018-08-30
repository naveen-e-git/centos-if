#!/bin/bash
   
yum update

if [ $? == 0 ]
then
          echo "################## THIS SYSTEM IS DEBIAN LINUX BASED PLATFORM #########################"
          echo "################### adding the repository and key for rabbitmq      ######################"
	  
	  echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
          echo
	  sudo wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
	  sudo wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc| sudo apt-key add -
          echo
          echo "################## installing  rabbitmq make configuration changes for queuing   ##############"
	  echo
	  sudo apt-get install rabbitmq-server -y
	  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
	  rabbitmqctl add_user test test
	  rabbitmqctl set_user_tags test administrator
	  sudo service rabbitmq-server start
	  sudo chkconfig rabbitmq-server on
	  sudo service rabbitmq-server status
          echo 
          echo "##### enabling the firewall and allowing port 25672 to access the rabbitmq permanently ######"
          #sudo ufw enable
          sudo ufw allow 25672/tcp
          sudo ufw status numbered

else

          echo "################# THIS SYSTEM IS REDHAT LINUX BASED PLATFORM #######################"
          echo
  
     	sudo yum update -y
     	sudo yum install wget -y
     	sudo yum install epel-release -y
          wget https://github.com/rabbitmq/erlang-rpm/releases/download/v19.3.6.8/erlang-19.3.6.8-1.e16.x86_64.rpm
          rpm -ivh erlang-19.3.6.8-1.e16.x86_64.rpm
    	 sudo yum install socat -y
          wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-3.6.9.el6.noarch.rpm
     	sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
     	sudo yum update -y
    	sudo rpm -ivh rabbitmq-server-3.6.9-1.noarch.rpm
     	sudo service rabbitmq-server start
     	sudo service rabbitmq-server status
     	sudo echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
     	sudo rabbitmqctl add_user test test
     	sudo rabbitmqctl set_user_tags test administrator

 fi    
