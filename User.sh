source common.sh
component=user


nodejs

echo -e "${color} Downloading the user file ${nocolor}"
curl -L -o /tmp/component.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>>log_file
cd ${app_path}

echo -e "${color} Extracing the user file  ${nocolor}"
unzip /tmp/user.zip  &>>log_file
cd ${app_path}

echo -e "${color} Install the dependencies ${nocolor}"
npm install   &>>log_file

echo -e "${color} setup SystemD service ${nocolor}"
cp /home/centos/robosho-shell/component.service /etc/systemd/system/component.service   &>>log_file


echo -e "${color} Reload repo ${nocolor}"
systemctl daemon-reload   &>>log_file
systemctl enable component   &>>log_file
systemctl restart component    &>>log_file




