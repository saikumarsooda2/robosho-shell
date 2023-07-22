echo -e "\e[33m installing nginx server \e[0m"
yum install nginx -y &>>tmp/roboshop.log

echo -e "\e[33m removing nginx demo server\e[0m"
rm -rf /usr/share/nginx/html/* &>>tmp/roboshop.log

echo -e "\e[33m downloading frontend file \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>tmp/roboshop.log

echo -e "\e[33m uniziping the frontend file \e[0m"
cd /usr/share/nginx/html &>>tmp/roboshop.log
unzip /tmp/frontend.zip &>>tmp/roboshop.log

echo -e "\e[33m copying the roboshop config file \e[0m"
cp frontend.conf /etc/nginx/default.d/roboshop.conf &>>tmp/roboshop.log

echo -e "\e[33m enabling the nginx server \e[0m"
systemctl enable nginx &>>tmp/roboshop.log
systemctl restart nginx &>>tmp/roboshop.log
