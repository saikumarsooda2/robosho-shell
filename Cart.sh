source common.sh
component=cart

nodejs

echo -e "\e[34m Downloading the cart file \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34m Extracing the cart file  \e[0m"
unzip /tmp/cart.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[34mInstall the dependencies \e[0m"
npm install   &>>/tmp/roboshop.log

echo -e "\e[34m setup SystemD service \e[0m"
cp /home/centos/robosho-shell/cart.service /etc/systemd/system/cart.service   &>>/tmp/roboshop.log

echo -e "\e[34m Reload repo \e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log
systemctl enable cart   &>>/tmp/roboshop.log
systemctl restart cart    &>>/tmp/roboshop.log
