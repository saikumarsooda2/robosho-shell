echo -e "/e[33m installing maven\ e[0m"
yum install maven -y   &>>/tmp/roboshop.log


echo -e "/e[33m user add roboshop\e[0m"
useradd roboshop   &>>/tmp/roboshop.log

echo -e "/e[33m creating application\e[0m"
rm -rf /app
mkdir /app    &>>/tmp/roboshop.log


echo -e "/e[33m downloading the shipping file \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip    &>>/tmp/roboshop.log
cd /app

echo -e "/e[33m Extracting the application \e[0m"
unzip /tmp/shipping.zip    &>>/tmp/roboshop.log
cd /app

echo -e "/e[33m installing the dependencies\e[0m"
mvn clean package      &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar       &>>/tmp/roboshop.log


echo -e "/e[33m installing mysql client server\e[0m"
yum install mysql -y     &>>/tmp/roboshop.log

echo -e "/e[33m load schema\e[0m"
mysql -h mysql-dev.devopspractice.lol -uroot -pRoboShop@1 < /app/schema/shipping.sql    &>>/tmp/roboshop.log


echo -e "/e[33m set systemD file\e[0m"
cp /home/centos/robosho-shell/shipping.repo /etc/systemd/system/shipping.service   &>>/tmp/roboshop.log  v

echo -e "/e[33m starting the shipping\e[0m"
systemctl daemon-reload     &>>/tmp/roboshop.log
systemctl enable shipping     &>>/tmp/roboshop.log
systemctl restart shipping     &>>/tmp/roboshop.log
