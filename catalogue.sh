echo -e "\e[33m nodejs repo setup [\e0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m install nodejs[\e0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add  app user[\e0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m create app location [\e0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m download the catalogue[\e0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m unzip the catalogue file[\e0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33m install npm[\e0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m copy the catalogue repo[\e0m"
cp ctalogue.repo /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m reload he server[\e0m"
systemctl daemon-reload  &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33m copy and install mongo client[\e0m"
cp mongoDB.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33m install mongo-shell[\e0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log


echo -e "\e[33m load the mongo scheme[\e0m"
mongo --host catalogue-dev.devopspractice.lol </app/schema/catalogue.js &>>/tmp/roboshop.log

