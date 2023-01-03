# january2023
### Install the nopcommerse application in linux and docker, kubernetes cluster.
 * follow the steps in the website to install the nop commerse appication `https://docs.nopcommerce.com/en/installation-and-upgrading/installing-nopcommerce/installing-on-linux.html`.

sample docker file 
---
FROM ubuntu:22.04 as unzip
RUN mkdir /Nop
RUN apt update && \
    apt install wget unzip -y && \
    cd /Nop && \
    wget "https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip" &&\
    unzip /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip && \
    rm /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip


FROM mcr.microsoft.com/dotnet/aspnet:6.0
LABEL author="khaja"
COPY  --from=unzip /Nop /Nop
WORKDIR /Nop
EXPOSE 80
CMD ["dotnet","/Nop/Nop.Web.dll"]
----
 ### While configuring the mysql server we are getting the following error 
      * ' Failed! Error: SET PASSWORD has no significance for user 'root'@'localhost' as the authentication method used doesn't store authentication data in the MySQL server. Please consider using ALTER USER instead if you want to change authentication parameters.' while we are performing the step "sudo /usr/bin/mysql_secure_installation"
* To rectify the error follow the steps provided in the website `https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04`.
----
 ### for the database to give the connections to remote host follow the link `https://www.digitalocean.com/community/tutorials/how-to-allow-remote-access-to-mysql`.

 follow the steps provided in the above website to give access to user from remote hostes.

-----
 * To Grant permissions to user created by user 'GRANT PRIVILEGES ON *.* TO 'vamsi'@'%';'
 * To delete a mysql user follow the steps :
1. First, connect to the MySQL database as the root user:

   `mysql -u root -p`

If root does not have access to MySQL on your machine, you can use sudo mysql

2. Enter the password when prompted and hit Enter. A MySQL shell loads.

3. Find the exact name of the user you want to remove by running a command that lists users from the MySQL server:

    `SELECT User, Host FROM mysql.user;`
4. The output displays all users. Locate the name you want to remove, in our case it is MySQLtest. Replace username in the following command with your user:

    `DROP USER 'username'@'host';`
----
* To create a user follow the steps : 
   1. `CREATE USER 'vamsi'@'localhost' IDENTIFIED BY 'Password@1234';`.
   2. `ALTER USER 'vamsi'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password@1234';`.
   3. To grant privilges: `GRANT ALL PRIVILEGES ON *.* TO 'vamsi'@'localhost';`.
   4. To grant all permissions `GRANT CREATE, ALTER, DROP, INSERT, UPDATE, INDEX, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'vamsi'@'localhost' WITH GRANT OPTION;`.
   5. `FLUSH PRIVILEGES;`
   6. exit
----
activity :
 ansible playbook :  follow the website:`https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-22-04`.
  1. install apache2 and skip mysql
  2. install PHP  no need to setup virtual host
      sudo nano /var/www/html/info.php