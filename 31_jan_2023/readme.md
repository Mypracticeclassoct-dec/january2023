# Integrate Ansible with Jenkins :
------------------------------------
## Step 1 Installing and configuring a Ansible node :
-----
* create a 2 virtual machines one for the jenkins master and one for ansible node.
* After creating the vm's from the aws console ssh to the jenkins master node `ssh ubuntu@<pubilc ip address>` from windows terminal.
*  After ssh to the jenkins master install the necessary software  to install jenkins in the machine .
        * `sudo apt update `
        * `sudo apt install openjdk-11-jdk -y `
* After installing the java now follow the steps provided in the following website to install jenkins in the vm `https://www.jenkins.io/doc/book/installing/linux/long-term-support-release`.
* To install the jenkins in the vm :
        * `curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null`
        * `echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null` 
        * ` sudo apt-get update`
        * `sudo apt-get install jenkins`  
*  After installing the jenkins configure jenkins by login to the jenkins console `< public-ip:8080 >` in a web-browser.
*  To configure the Ansible node ssh to the vm and install the java-11 version so that jenkins will connect to the node .
*  After installing the java version and updating the packages.
*  TO install ansible make sure python3 and pip3 is installed in the machine.To install ansible follow the link `https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu`.
*  now create an ansible user with username and password or we can us the ubuntu dafault user .give the sudo permissions to the user and nopassword to the user.
*  After giving the passowrd to user try to login to the from the jenkins machine.
*  go to manage jenkins and configure the ansible node , here i didn't create new user i have used the existing ubuntu user.
*  After the node is connected the configuration is done.
------------------
## Step2 : Install Terraform and create an resource :
* Install Terraform in the ansible node.
       ``` sudo apt update
         sudo apt install  software-properties-common gnupg2 curl
          curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
        sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
        sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt install terraform
       ```
* Write a terraform file to create an vpc or subnet.
* write a declarative pipeline to run the terraform.