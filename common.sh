color="\e[33m"
nocolor="\e[0m"
app_path="/app"
log_file="/tmp/roboshop.log"



nodejs() {

     echo -e "${color}  Downloading the nodejs repo ${nocolor}"
     curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file

     echo -e "${color} Installing nodejs ${nocolor}"
     yum install nodejs -y &>>log_file

     echo -e "${color} Adding the user ${nocolor}"
     useradd roboshop &>>log_file

     echo -e "${color} Creating the app ${nocolor}"
     rm -rf ${app_path}
     mkdir ${app_path} &>>log_file

}


mongo_schema_repo() {

      echo -e "${color} copy mongoDB repo ${nocolor}"
      cp /home/centos/robosho-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file

      echo -e "${color} Installing MongoDB Client ${nocolor}"
      yum install mongodb-org-shell -y &>>log_file

      echo -e "${color} Load Schema${nocolor}"
      mongo --host mongodb-dev.devopspractice.lol </app/schema/user.js &>>log_file
}