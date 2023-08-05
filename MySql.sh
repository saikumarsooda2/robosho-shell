source common.sh
echo -e "\e[33m Disable Mysql default \e[0m"
yum module disable mysql -y   &>>log_file
status_check $?

echo -e "\e[33m Copying mysql repo file \e[0m"
cp /home/centos/robosho-shell/mysql.repo  /etc/yum.repos.d/mysql.repo  &>>log_file
status_check $?


echo -e "\e[33m installing mysql community server  \e[0m"
yum install mysql-community-server -y  &>>log_file
status_check $?

echo -e "\e[33m  starting mysql \e[0m"
systemctl enable mysqld   &>>log_file
status_check $?
systemctl restart mysqld   &>>log_file
status_check $?

echo -e "\e[34m Setup a Mysql Password  \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1  &>>log_file
status_check $?

