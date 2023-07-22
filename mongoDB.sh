echo -e "\e[33m cofiguring mongdb repo\e[0m"
cp mongoDB.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33m installing mongodb \e[0m"
yum install mongodb-org-yum &>>/tmp/roboshop.log

echo -e "\e[33m updating the mongodb listening address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0' /etc/mongo.conf &>>/tmp/roboshop.log

echo -e "\e[33m enable and starting the mongodb\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log