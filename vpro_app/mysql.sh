#!/bin/bash 

yum update

if [ $? == 0 ]
then
##############################################################################################

          echo "######## THIS SYSTEM WORKS ON DEBIAN LINUX  PLATFORM ########## "
          echo "installing mysql-server on ubuntu"
          sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
          sudo  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
          sudo apt-get update
          sudo apt-get install mysql-server -y
          sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
          echo "restoring  the dump file for the application"
          mysql -u root -e "create database accounts" --password='root';
          mysql -u root -e "grant all privileges on *.* TO 'root'@'app.com' identified by 'root'" --password='root';
          mysql -u root -e "grant all privileges on *.* TO 'root'@'%' identified by 'root'" --password='root';
          mysql -u root -e "create user 'admin'@'%' identified by 'admin123'" --password='root';
          mysql -u root -e "grant all privileges on *.* TO 'admin'@'%' identified by 'admin123'" --password='root';
          mysql -u root --password='root' accounts < ~/VProfile/src/main/resources/db_backup.sql;
          
          mysql -u root -e "FLUSH PRIVILEGES" --password='root';
          sudo  service mysql restart

          echo "adding mysql service to firewall"
          echo
          sudo ufw allow 3306/tcp
          sudo ufw status numbered
          echo

else

##############################################################################################################

          echo "######## THIS SYSTEM WORKS ON REDHAT LINUX PLATFORM"
          echo "installing  mariadb-server on centos"
          echo
          sudo yum install epel-release -y
          sudo yum install mysql-server -y

          sudo service mysqld start
          sudo echo "bind-address = 0.0.0.0" >>  /etc/my.cnf

          echo  "restoring  the dump file for the application"
          mysql -u root -e "create database accounts" --password='';
	  mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'app01.com' identified by 'root'" --password='';
	  mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' identified by 'root'" --password='';
          mysql -u root -e "grant all privileges on *.* TO 'root'@'%' identified by 'root'" --password='';
          mysql -u root --password='' accounts < /vagrant/vpro_app/VProfile/src/main/resources/db_backup.sql;
          mysql -u root -e "FLUSH PRIVILEGES" --password='';
          echo "starting & enabling mysql-server"
          sudo service mysqld restart 
          sudo chkconfig mysqld on
          echo "starting the firewall and allowing the mariadb to access from port no. 3306"
          
fi
