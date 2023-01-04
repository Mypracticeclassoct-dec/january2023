# Install wildfly application  manualy and ansible playbook :
----
*  follow the link to install in ubuntu vm :`https://computingforgeeks.com/install-wildfly-application-server-on-ubuntu-debian/`.
----
Step 1: Install Java -11  JDK on Ubuntu .WildFly is written in Java and it need to be installed as pre-requisite.
    `sudo apt update`
    `sudo apt  install openjdk-11-jdk -y `
    `java --version`
----

Step 2: Download WildFly Installation archive

* Get the latest wildfly file from the link : `https://www.wildfly.org/downloads/` and copy the tar file link : `https://github.com/wildfly/wildfly/releases/download/27.0.1.Final/wildfly-27.0.1.Final.tar.gz`.
* make sure you have curl and weget in your ubuntu vm,if not install them.
  
  Install curl and wget tools

  `sudo apt install curl wget -y `
* Download the tar file in ubuntu vm :

  `wget https://github.com/wildfly/wildfly/releases/download/27.0.1.Final/wildfly-27.0.1.Final.tar.gz `

Once the file is downloaded, extract it.

   `tar xvf wildfly-27.0.1.Final.tar.gz`

Move resulting folder to `/opt/wildfly` .
  
  Rename the wildfly-27.0.1.Final folder to wildfly by using the command `sudo mv wildfly-27.0.1.Final  wildfly`. after move it to the `/opt/wildfly` for this you should be in the tmp folder where you extracted the file.

   `sudo mv wildfly /opt/wildfly`

Step 3: Configure Systemd for WildFly

Let’s now create a system user and group that will run WildFly service.

sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly

Create WildFly configurations directory.

sudo mkdir /etc/wildfly

Copy WildFly systemd service, configuration file and start scripts templates from the /opt/wildfly/docs/contrib/scripts/systemd/ directory.

sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chmod +x /opt/wildfly/bin/launch.sh

Set /opt/wildfly permissions.

sudo chown -R wildfly:wildfly /opt/wildfly

Reload systemd service.

sudo systemctl daemon-reload

Start and enable WildFly service:

sudo systemctl start wildfly
sudo systemctl enable wildfly

Confirm WildFly Application Server status.

sudo systemctl status wildfly

Sample output:
wildfly check status

Service should bind to port 8080.

$ ss -tunelp | grep 8080
tcp    LISTEN   0   128    0.0.0.0:8080  0.0.0.0:*  users:(("java",pid=6854,fd=389)) uid:999 ino:30339 sk:3 <-> 

Step 4: Add WildFly Users

By default WildFly 16 is now distributed with security enabled for the management interfaces. We need to create a user who can access WildFly administration console or remotely use the CLI. A script is provided for managing users.

Run it by executing the command:

sudo /opt/wildfly/bin/add-user.sh

You will be asked to choose type of user to add. Since this the first user, we want to make it admin. So choose a.

What type of user do you wish to add? 
  a) Management User (mgmt-users.properties) 
  b) Application User (application-users.properties)
 (a):  a

Provide desired username for the user.

Enter the details of the new user to add.
 Using realm 'ManagementRealm' as discovered from the existing property files.
 Username : computingforgeeks

Set password for the user:

Password recommendations are listed below. To modify these restrictions edit the add-user.properties configuration file.
The password should be different from the username
The password should not be one of the following restricted values {root, admin, administrator}
The password should contain at least 8 characters, 1 alphabetic character(s), 1 digit(s), 1 non-alphanumeric symbol(s)
Password : <Enter Password>
Re-enter Password :  <Confirm Password>

Press enter and agree to subsequent prompts to finish user creation.

What groups do you want this user to belong to? (Please enter a comma separated list, or leave blank for none)[  ]: <Enter>
 About to add user 'computingforgeeks' for realm 'ManagementRealm'
 Is this correct yes/no? yes
 Added user 'computingforgeeks' to file '/opt/wildfly/standalone/configuration/mgmt-users.properties'
 Added user 'computingforgeeks' to file '/opt/wildfly/domain/configuration/mgmt-users.properties'
 Added user 'computingforgeeks' with groups  to file '/opt/wildfly/standalone/configuration/mgmt-groups.properties'
 Added user 'computingforgeeks' with groups  to file '/opt/wildfly/domain/configuration/mgmt-groups.properties'
 Is this new user going to be used for one AS process to connect to another AS process? 
 e.g. for a slave host controller connecting to the master or for a Remoting connection for server to server EJB calls.
 yes/no? yes
 To represent the user add the following to the server-identities definition 

Notice that:

User information is kept on: /opt/wildfly/domain/configuration/mgmt-users.properties
Group information is kept on: /opt/wildfly/standalone/configuration/mgmt-groups.properties
Step 5: Accessing WildFly Admin Console

To be able to run WildFly scripts from you current shell session, add /opt/wildfly/bin/ to your $PATH.

cat >> ~/.bashrc <<EOF
export WildFly_BIN="/opt/wildfly/bin/"
export PATH=\$PATH:\$WildFly_BIN                                                                                                                    
EOF

Source the bashrc file.

source ~/.bashrc

Now test by connecting to WildFly Admin Console from CLI with jboss-cli.sh command.

$ jboss-cli.sh --connect
Authenticating against security realm: ManagementRealm
Username: computingforgeeks
Password:
[standalone@localhost:9990 /] version
JBoss Admin Command-line Interface
JBOSS_HOME: /opt/wildfly
Release: 26.0.1.Final
Product: WildFly Full 26.0.1.Final
JAVA_HOME: null
java.version: 11.0.13
java.vm.vendor: Ubuntu
java.vm.version: 11.0.13+8-Ubuntu-0ubuntu1
os.name: Linux
os.version: 5.13.0-19-generic
[standalone@localhost:9990 /] exit

Accessing WildFly Admin Console from Web Interface

By default, the console is accessible on localhost IP on port 9990.

$ ss -tunelp | grep 9990
tcp    LISTEN   0    50    127.0.0.1:9990  0.0.0.0:* users:(("java",pid=6769,fd=404)) uid:999 ino:30407 sk:3 <-> 

We can start it on a different IP address accessible from outside the local server. Edit /opt/wildfly/bin/launch.sh to look like this:

$ sudo vim /opt/wildfly/bin/launch.sh
#!/bin/bash

if [ "x$WILDFLY_HOME" = "x" ]; then
    WILDFLY_HOME="/opt/wildfly"
fi

if [[ "$1" == "domain" ]]; then
    $WILDFLY_HOME/bin/domain.sh -c $2 -b $3
else
    $WILDFLY_HOME/bin/standalone.sh -c $2 -b $3 -bmanagement=0.0.0.0
fi

We added -bmanagement=0.0.0.0 to start script line. This binds “management” interface to all available IP addresses.

Restart wildfly service

sudo systemctl restart wildfly

Check service status to confirm it was successful

$ systemctl status  wildfly
● wildfly.service - The WildFly Application Server
     Loaded: loaded (/etc/systemd/system/wildfly.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2021-12-24 12:11:21 EAT; 6s ago
   Main PID: 8205 (launch.sh)
      Tasks: 70 (limit: 9482)
     Memory: 159.8M
        CPU: 12.265s
     CGroup: /system.slice/wildfly.service
             ├─8205 /bin/bash /opt/wildfly/bin/launch.sh standalone standalone.xml 0.0.0.0
             ├─8206 /bin/sh /opt/wildfly/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement=0.0.0.0
             └─8305 java -D[Standalone] -server -Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=org.jboss.byteman -Djava>

Des 24 12:11:21 ubuntu22 systemd[1]: Started The WildFly Application Server.

Confirm port 9990 is listening:

$ ss -tunelp | grep 9990
tcp    LISTEN   0  50     0.0.0.0:9990  0.0.0.0:*  users:(("java",pid=9496,fd=320)) uid:999 ino:73367 sk:c <->

Open your browser and URL http://serverip:9990 to access WildFly Web console.
wildfly console login