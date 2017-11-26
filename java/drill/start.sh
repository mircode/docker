#!/bin/bash

# env
export ZOO_LOG_DIR=$APP_HOME/zookeeper/logs

# ln
ln -s $APP_HOME/drill/bin/sql.sh ./sql

# start
./zookeeper/bin/zkServer.sh start
./drill/bin/drillbit.sh start

# log
tail -f ./drill/log/drillbit.out