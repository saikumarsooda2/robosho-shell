color="\e[33m"
nocolor="\e[0m"
app_path="/app"
log_file="/tmp/roboshop.log"

status_check() {
  if [ $? -eq 0 ]; then
    echo SUCCESS
    else
    echo  FAILURE
  fi
}

app_presetup() {
        echo -e "${color} Adding the user ${nocolor}"
        id roboshop &>>log_file
        if [ $? -eq 1 ]; then
          useradd roboshop   &>>log_file
        fi
        if [ $? -eq 0 ]; then
            echo SUCCESS
        else
              echo FAILURE
        fi
        status_check $?

        echo -e "${color} Creating the app ${nocolor}"
        rm -rf ${app_path}
        mkdir ${app_path} &>>log_file
        status_check $?

        echo -e "${color} Downloading the user file ${nocolor}"
        curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>log_file
        cd ${app_path}
        status_check $?

        echo -e "${color} Extracting the user file  ${nocolor}"
        unzip /tmp/${component}.zip  &>>log_file
        status_check $?
}

    systemD_setup() {

      echo -e "${color} setup SystemD service ${nocolor}"
      cp /home/centos/robosho-shell/${component}.service /etc/systemd/system/${component}.service   &>>log_file
      status_check $?

      echo -e "${color} Reload repo ${nocolor}"
      systemctl daemon-reload      &>>log_file
      status_check $?
      systemctl enable $component   &>>log_file
      status_check $?
      systemctl restart $component    &>>log_file
      status_check $?
    }


nodejs() {

      echo -e "${color}  Downloading the nodejs repo ${nocolor}"
      curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file
      status_check $?

      echo -e "${color} Installing nodejs ${nocolor}"
      yum install nodejs -y &>>log_file
      status_check $?

      app_presetup

      echo -e "${color} Install the dependencies ${nocolor}"
      npm install   &>>log_file
      status_check $?

      systemD_setup

}

maven() {
  echo -e "\e[33m install golang \e[0m"
  yum install golang -y   &>>/tmp/roboshop.log
  status_check $?

  app_presetup

  echo -e "\e[33m Initializing Dispatch \e[0m"
  go mod init dispatch   &>>/tmp/roboshop.log
  status_check $?
  go get                 &>>/tmp/roboshop.log
  status_check $?
  go build               &>>/tmp/roboshop.log
  status_check $?

  systemD_setup
}
mongo_schema_repo() {

      echo -e "${color} copy mongoDB repo ${nocolor}"
      cp /home/centos/robosho-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
      status_check $?

      echo -e "${color} Installing MongoDB Client ${nocolor}"
      yum install mongodb-org-shell -y &>>log_file
      status_check $?

      echo -e "${color} Load Schema${nocolor}"
      mongo --host mongodb-dev.devopspractice.lol <${app_path}/schema/$component.js &>>log_file
      status_check $?
}

python() {
  echo -e "\e[33m Installing Python\e[0m"
  yum install python36 gcc python3-devel -y  &>>/tmp/roboshop.log
  status_check $?

  app_presetup

  echo -e "\e[33m Installing Dependencies\e[0m"
   pip3.6 install -r requirements.txt   &>>/tmp/roboshop.log
   status_check $?

  systemD_setup
}







