echo -e "\e[34m  Downloading the nodejs repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[34m Installing nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log


echo -e "\e[34m Adding the user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m Creating the app \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[34m Downloading the user file \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34m Extracing the user file  \e[0m"
unzip /tmp/user.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34mInstall the dependencies \e[0m"
npm install   &>>/tmp/roboshop.log

echo -e "\e[34m setup SystemD service \e[0m"
cp /home/centos/robosho-shell/user.service /etc/systemd/system/user.service   &>>/tmp/roboshop.log


echo -e "\e[34m Reload repo \e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log


echo -e "\e[34m enable user\e[0m"
systemctl enable user   &>>/tmp/roboshop.log
systemctl start user    &>>/tmp/roboshop.log
