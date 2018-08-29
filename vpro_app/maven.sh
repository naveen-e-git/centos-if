#!/bin/bash

 cd /opt
 wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar zxvf apache-maven-3.3.9-bin.tar.gz
mv apache-maven-3.3.9/ /opt/maven
ln -s /opt/maven/bin/mvn /usr/bin/mvn

sudo echo "#!/bin/bash" >> /etc/profile.d/maven.sh
sudo echo "MAVEN_HOME=/opt/maven" >> /etc/profile.d/maven.sh 
sudo echo "PATH=$MAVEN_HOME/bin:$PATH" >> /etc/profile.d/maven.sh
sudo echo "export PATH MAVEN_HOME" >> /etc/profile.d/maven.sh
sudo echo "export CLASSPATH=." >> /etc/profile.d/maven.sh

sudo chmod +x /etc/profile.d/maven.sh

source /etc/profile.d/maven.sh

sudo echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk.x86_64/" >> /root/.bashrc

source /root/.bashrc
