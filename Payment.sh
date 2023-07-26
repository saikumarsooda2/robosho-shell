echo -e "\e[33m Installing Python\e[0m"
yum install python36 gcc python3-devel -y  &>>/tmp/roboshop.log

echo -e "\e[33m Add Application User \e[0m"
useradd roboshop    &>>/tmp/roboshop.log

echo -e "\e[33m Creating Application \e[0m"
rm -rf /app
mkdir /app   &>>/tmp/roboshop.log

echo -e "\e[33m Downloading Payment File\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Extracting Payment File \e[0m"
unzip /tmp/payment.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Installing Dependencies\e[0m"
 pip3.6 install -r requirements.txt   &>>/tmp/roboshop.log

echo -e "\e[33m Copying Payment service \e[0m"
 cp /root/robosho-shell/payment.service /etc/systemd/system/payment.service   &>>/tmp/roboshop.log

echo -e "\e[33m Starting Payment \e[0m"
 systemctl daemon-reload    &>>/tmp/roboshop.log
 systemctl enable payment  &>>/tmp/roboshop.log
 systemctl restart payment   &>>/tmp/roboshop.log

