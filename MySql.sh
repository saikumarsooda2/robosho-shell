echo -e "\e[33m Disable Mysql default \e[0m"
yum module disable mysql -y   &>>/tmp/roboshop.log

echo -e "\e[33m Copying mysql repo file \e[0m"
cp /home/centos/robosho-shell/robosho-shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>>/tmp/roboshop.log



echo -e "\e[33m installing mysql community server  \e[0m"
yum install mysql-community-server -y  &>>/tmp/roboshop.log


echo -e "\e[33m  starting mysql \e[0m"
systemctl enable mysqld   &>>/tmp/roboshop.log
systemctl start mysqld   &>>/tmp/roboshop.log

echo -e "\e[34m Setup a Mysql Password  \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1  &>>/tmp/roboshop.log

