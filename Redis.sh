echo -e "\e[33m installing redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log


echo -e "\e[33m enable redis version \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[33m install redis\e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[33m update redis listening address\e[0m"
sed -i 's/127.0.0.0/0.0.0.0/' /etc/redis/redis.conf    &>>/tmp/roboshop.log


echo -e "\e[33m enable redis\e[0m"
systemctl enable redis  &>>/tmp/roboshop.log
systemctl start redis  &>>/tmp/roboshop.log