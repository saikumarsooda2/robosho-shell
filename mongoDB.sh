source common.sh
echo -e "\e[33m copy  mongoDB repo\e[0m"
cp /home/centos/robosho-shell/mongo.repo /etc/yum.repos.d/mongo.repo    &>>log_file
 status_check $?

echo -e "\e[33m installing mongodb \e[0m"
yum install mongodb-org -y   &>>log_file
status_check $?

echo -e "\e[33m updating the yum install mongodb-org -y mongodb listening address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf   &>>log_file
status_check $?

echo -e "\e[33m enable and starting the mongodb\e[0m"
systemctl enable mongod     &>>log_file
status_check $?
systemctl restart mongod    &>>log_file
status_check $?