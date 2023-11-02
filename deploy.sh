#!/usr/bin/env bash

ROOT_PATH=/home/ec2-user/app
REPOSITORY=$ROOT_PATH/game-moa-gateway
cd $REPOSITORY

APP_NAME=game-moa-gateway
JAR_NAME=$(ls $REPOSITORY/ | grep '.jar' | tail -n 1)
JAR_PATH=$REPOSITORY/$JAR_NAME

CURRENT_PID=$(pgrep -f $APP_NAME)

echo "> Kill Previous Process" >> $REPOSITORY/deploy.log

if [ -z "$CURRENT_PID" ]
then
  echo "> No Process to Kill" >> $REPOSITORY/deploy.log
else
  echo "> Kill $CURRENT_PID" >> $REPOSITORY/deploy.log
  kill -15 "$CURRENT_PID" >> $REPOSITORY/deploy.log 2>&1
  sleep 5
fi

echo "> $JAR_PATH Deploy"
nohup java -jar -Dspring.profiles.active=dev $JAR_PATH >> $REPOSITORY/nohup.log 2>&1 &