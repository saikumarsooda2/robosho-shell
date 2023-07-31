
component=user
color="\e[33m"
nocolor="\e[0m"
app_path="/app"
log_file="/tmp/roboshop.log"

echo -e "${color}  Downloading the nodejs repo ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file
echo $?

echo -e "${color} Installing nodejs ${nocolor}"
yum install nodejs -y &>>log_file
echo $?

echo -e "${color} Adding the user ${nocolor}"
useradd roboshop &>>log_file
echo $?

echo -e "${color} Creating the app ${nocolor}"
rm -rf ${app_path}
mkdir ${app_path} &>>log_file
echo $?


echo -e "${color} Downloading the user file ${nocolor}"
curl -L -o /tmp/component.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>>log_file
cd ${app_path}
echo $?

echo -e "${color} Extracing the user file  ${nocolor}"
unzip /tmp/user.zip  &>>log_file
cd ${app_path}
echo $?

echo -e "${color} Install the dependencies ${nocolor}"
npm install   &>>log_file
echo $?

echo -e "${color} setup SystemD service ${nocolor}"
cp /home/centos/robosho-shell/component.service /etc/systemd/system/component.service   &>>log_file
echo $?


echo -e "${color} Reload repo ${nocolor}"
systemctl daemon-reload   &>>log_file
echo $?
systemctl enable component   &>>log_file
echo $?
systemctl restart component    &>>log_file
echo $?


echo -e "${color} copy mongdb repo ${nocolor}"
cp /home/centos/robosho-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
echo $?


echo -e "${color} Installing MongoDB Client ${nocolor}"
yum install mongodb-org-shell -y &>>log_file
echo $?

echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopspractice.lol  </app/schema/user.js &>>log_file
echo $?

