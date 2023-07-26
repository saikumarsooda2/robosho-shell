echo -e "\e[33m install golang \e[0m"
yum install golang -y   &>>/tmp/roboshop.log


echo -e "\e[33m  Adding Application User \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

echo -e "\e[33m Creating Application \e[0m"
rm -rf /app
mkdir /app   &>>/tmp/roboshop.log

echo -e "\e[33m Downloading Dispatch File  \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mExtracting Application  \e[0m"
unzip /tmp/dispatch.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Initializing Dispatch \e[0m"
go mod init dispatch   &>>/tmp/roboshop.log
go get   &>>/tmp/roboshop.log
go build   &>>/tmp/roboshop.log

echo -e "\e[33m Copying Dispatch Service File \e[0m"
cp /home/centos/robosho-shell/dispatch.service  /etc/systemd/system/dispatch.service   &>>/tmp/roboshop.log

echo -e "\e[33m Starting Dispatch \e[0m"
systemctl daemon-reload    &>>/tmp/roboshop.log
systemctl enable dispatch    &>>/tmp/roboshop.log
systemctl start dispatch    &>>/tmp/roboshop.log