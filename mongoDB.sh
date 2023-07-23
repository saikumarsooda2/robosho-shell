echo -e "\e[33m copy  mongoDB repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo     &>>/tmp/roboshop.log

echo -e "\e[33m installing mongodb \e[0m"
yum install mongodb-org -y   &>>/tmp/roboshop.log

echo -e "\e[33m updating the yum install mongodb-org -y mongodb listening address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf     &>>/tmp/roboshop.log

echo -e "\e[33m enable and starting the mongodb\e[0m"
systemctl enable mongod     &>>/tmp/roboshop.log
systemctl restart mongod    &>>/tmp/roboshop.log