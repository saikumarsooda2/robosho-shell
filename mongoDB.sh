echo -e "\e[33m cofiguring mongdb repo \[0m"
cp mongoDB.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33m installing mongodb \e[0m"
yum install mongodb-org-yum &>>/tmp/roboshop.log
## modify the conf with new ip address
echo -e "\e[33m enable and starting the mongodb \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log