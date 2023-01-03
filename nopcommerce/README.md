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