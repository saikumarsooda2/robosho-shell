echo -e "\e[33m nodejs repo setup \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m install nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add  app user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m create app location \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m download the catalogue\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m unzip the catalogue file\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m install npm\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m copy the catalogue repo\e[0m"
cp ctalogue.repo /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m reload he server\e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33m copy and install mongo client\e[0m"
cp mongoDB.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log

echo -e "\e[33m install mongo-shell\e[0m"
yum install mongodb-org-shell -y  &>>/tmp/roboshop.log


echo -e "\e[33m load the mongo scheme\e[0m"
mongo --host mongodb-dev.devopspractice.lol </app/schema/catalogue.js  &>>/tmp/roboshop.log

