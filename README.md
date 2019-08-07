
# PARAMS
BASEDIR: file directory ex: $(dirname "$0")

### IDENTIFICATION CONFIG
ENVIRONMENT_NAME: identification, also also logfile name

### ENVIRONMENT CONFIG
PROJECT_PATH: root project path frontend or backend
MAVEN_PROFILE: maven build profile ex: dev, prod
BUILD_FILES: files to send to server

### SERVER CONFIG
PASSPHERE: password server
PPK_FILE: primary key in ppk format
PEM_FILE: primary key in pem format
REMOTE_USER: user to loggin on server
IP: server ip
REMOTE_BUILD_PATH: path on server to send build files
RESTART_COMAND: comand to start the build in server

### USE THIS LINE TO IMPORT THIS SCRIPT
source "yourpath/deploy-scripts.sh"

### EXECUTE
build-backend &&
send-build && 
restart-build 
