source common.sh
echo -e "\e[33m installing redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y   &>>log_file
status_check $?


echo -e "\e[33m enable redis version \e[0m"
yum module enable redis:remi-6.2 -y   &>>log_file
status_check $?

echo -e "\e[33m install redis\e[0m"
yum install redis -y   &>>log_file
status_check $?

echo -e "\e[33m update redis listening address\e[0m"
sed -i -e 's/127.0.0.0/0.0.0.0/'  /etc/redis.conf  /etc/redis/redis.conf    &>>log_file
status_check $?


echo -e "\e[33m enable redis\e[0m"
systemctl enable redis  &>>log_file
status_check $?
systemctl restart redis  &>>log_file
status_check $?