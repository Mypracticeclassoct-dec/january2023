# Install wildfly on centos7:
----
*  follow the steps given in the link `https://computingforgeeks.com/how-to-install-wildfly-jboss-on-rhel-centos/`.
```
sudo yum update -y
sudo yum install java-11-openjdk -y
sudo yum install wget curl -y 
wget https://github.com/wildfly/wildfly/releases/download/27.0.1.Final/wildfly-27.0.1.Final.tar.gz
tar xvf wildfly-27.0.1.Final.tar.gz
sudo mv wildfly-27.0.1.Final wildfly
sudo mv wildfly /opt/wildfly
sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly
sudo mkdir /etc/wildfly
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chmod +x /opt/wildfly/bin/launch.sh
sudo chown -R wildfly:wildfly /opt/wildfly
sudo systemctl daemon-reload
sudo semanage fcontext  -a -t bin_t  "/opt/wildfly/bin(/.*)?"
sudo restorecon -Rv /opt/wildfly/bin/
sudo systemctl start wildfly
sudo systemctl enable wildfly
systemctl status wildfly
sudo ss -tunelp | grep 8080
sudo /opt/wildfly/bin/add-user.sh
management user:vamsi,Password@1 
  `cat >> ~/.bashrc <<EOF
    export WildFly_BIN="/opt/wildfly/bin/"
    export PATH=\$PATH:\$WildFly_BIN
    EOF`
source ~/.bashrc
jboss-cli.sh --connect
sudo ss -tunelp | grep 9990
sudo vi /opt/wildfly/bin/launch.sh
 in that change the file :
   .....
if [[ "$1" == "domain" ]]; then
    $WILDFLY_HOME/bin/domain.sh -c $2 -b $3
else
    $WILDFLY_HOME/bin/standalone.sh -c $2 -b $3 -bmanagement=0.0.0.0 
fi 

sudo systemctl restart wildfly
ss -tunelp | grep 9990

```