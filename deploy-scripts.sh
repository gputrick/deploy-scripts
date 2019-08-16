#!/bin/bash -i

#SET TERMINAL TITLE
echo -en "\033]0;$ENVIRONMENT_NAME\a"

#exit 1 //exit on fail
build-frontend()
{
    echo "---------- START BUILD FRONTEND -----------"
    cd $PROJECT_PATH || exit 1
    npm rebuild node-sass  || exit 1
    npm run-script $NPM_SCRIPT  || exit 1
    cd $BUILD_PATH  || exit 1
    zip -r $ZIP_NAME ./*  || exit 1
    echo "---------- END BUILD FRONTEND -----------"
}

build-backend()
{
    echo "---------- START BUILD BACKEND -----------"
    cd $PROJECT_PATH  || exit 1
    mvn clean package install -P"$MAVEN_PROFILE"  || exit 1
    echo "---------- END BUILD BACKEND -----------"
}

send-build() 
{
    echo "---------- START TO SEND BUILD TO REMOTE ENVIRONMENT -----------"
    pscp \
        -i $PPK_FILE \
        -pw $PASSPHERE \
        $BUILD_FILES \
        "$REMOTE_USER@$IP:$REMOTE_BUILD_PATH"  || exit 1
    echo "---------- END TO SEND BUILD TO REMOTE ENVIRONMENT -----------"
}

restart-build()
{
    echo "---------- START TO RESTART BUILD IN REMOTE ENVIROMENT -----------"
    notify-send -i important "Build complete!" "See terminal to insert passphere"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    echo $PASSPHERE  || exit 1
    ssh -i $PEM_FILE "$REMOTE_USER@$IP" $RESTART_COMAND  || exit 1
    echo "---------- END RESTART BUILD IN REMOTE ENVIROMENT -----------"
}

#LOGGING
LOG_FILE="$BASEDIR/$ENVIRONMENT_NAME.log"
> $LOG_FILE #clear log file
exec 1> >(mawk -W interactive "{\"date\" | getline d; print \$0; print d, \$0 >> \"$LOG_FILE\"}")
exec 2>&1