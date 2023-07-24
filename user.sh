echo -e "\e[34m  Downloading the nodejs repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m Installing nodejs \e[0m"
yum install nodejs -y


echo -e "\e[34m Adding the user \e[0m"
useradd roboshop

echo -e "\e[34m Creating the app \e[0m"
rm -rf /app
mkdir /app


echo -e "\e[34m Downloading the user file \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[34m Extracing the user file  \e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[34mInstall the dependencies \e[0m"
npm install


echo -e "\e[34m Reload repo \e[0m"
systemctl daemon-reload


echo -e "\e[34m enable user\e[0m"
systemctl enable user
systemctl start user
