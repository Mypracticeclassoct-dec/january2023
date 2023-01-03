# Setup of Ansible in ubuntu virtual machine:
----
* launch 2 vm's and name the vm's :
   1. ansible control node.
   2. ansible node.
----
* Create user in both the machines with same user name and password.
* add sudo visudo permissions `<username>  ALL=(ALL:ALL) NOPASSWD:ALL`.
* change the password authentication from "no" to "yes" in /etc/ssh/sshd_config.
* After changing the setting restart `sshd` "sudo systemctl restart sshd".
* After restarting the service generate an "ssh"key by swwitching to the user '<usercreated by user>', follow the `ssh-keygen`,and copy the id_rsa.pub key to the ansible node by using `ssh-copy-id  <user>@<private_ip of node>`.
* After copying the key , install python3 and pip3 in both the machines and install ansible in the ansible control node.
----
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
----
*   To ping the node : "ansible -i inventory -k -m ping all".
*   To check syntax the ansible playbook.yaml file `ansible-playbook -i hosts --syntax-check php.yaml`.
*   To run the  ansible playbook `ansible-playbook -i hosts  php.yaml`.

*  https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html#examples for ansible copy file module.
*  https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html#examples to create a file in a directory.
