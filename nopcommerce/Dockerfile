FROM ubuntu:22.04
RUN apt update &&\
    apt install wget unzip -y && \
    mkdir nop
WORKDIR /nop
RUN wget https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.0/nopCommerce_4.60.0_NoSource_linux_x64.zip &&\
    unzip nopCommerce_4.60.0_NoSource_linux_x64.zip && \
    rm nopCommerce_4.60.0_NoSource_linux_x64.zip 
EXPOSE 80
CMD [ "dotnet", "/nop/Nop.Web.dll" ] 