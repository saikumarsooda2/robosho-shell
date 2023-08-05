source common.sh

echo -e "\e[33m installing nginx server \e[0m"
yum install nginx -y &>>log_file
status_check $?

echo -e "\e[33m removing nginx demo server\e[0m"
rm -rf /usr/share/nginx/html/* &>>log_file
status_check $?

echo -e "\e[33m downloading frontend file \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>log_file
status_check $?

echo -e "\e[33m unziping the frontend file \e[0m"
cd /usr/share/nginx/html  &>>log_file
unzip /tmp/frontend.zip  &>>log_file
status_check $?

echo -e "\e[33m copying the roboshop config file \e[0m"
cp /home/centos/robosho-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf   &>>log_file
status_check $?

echo -e "\e[33m enabling the nginx server \e[0m"
systemctl enable nginx   &>>log_file
status_check $?
systemctl restart nginx   &>>log_file
status_check $?
