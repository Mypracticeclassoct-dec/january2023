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

    `sudo groupadd --system wildfly`
    `sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly `
*  Create WildFly configurations directory.
    `sudo mkdir /etc/wildfly`
*  Copy WildFly systemd service, configuration file and start scripts templates from the /opt/wildfly/docs/contrib/scripts/systemd/ directory.
```
    `sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/`
    `sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/`
    `sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/`
    `sudo chmod +x /opt/wildfly/bin/launch.sh`
```
* Set `/opt/wildfly` permissions.

    `sudo chown -R wildfly:wildfly /opt/wildfly`

* Reload systemd service.

    `sudo systemctl daemon-reload`

* Start and enable WildFly service:

    `sudo systemctl start wildfly`
    `sudo systemctl enable wildfly`

*  Confirm WildFly Application Server status.

    `sudo systemctl status wildfly`
----
![Alt text](../../../../AWS_Quality_Thoughts/AWS_Screenshots/Ansible_2023/4thjan/ansible_wildfly_op.png)