echo -e "\e[34m  Downloading the nodejs repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[34m Installing nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log


echo -e "\e[34m Adding the cart \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m Creating the app \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[34m Downloading the cart file \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34m Extracing the cart file  \e[0m"
unzip /tmp/cart.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34mInstall the dependencies \e[0m"
npm install   &>>/tmp/roboshop.log

echo -e "\e[34m setup SystemD service \e[0m"
cp cart.service /etc/systemd/system/cart.service   &>>/tmp/roboshop.log


echo -e "\e[34m Reload repo \e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log
systemctl enable cart   &>>/tmp/roboshop.log
systemctl restart cart    &>>/tmp/roboshop.log
