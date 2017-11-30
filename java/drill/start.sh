#!/bin/bash

# env
export ZOO_LOG_DIR=$APP_HOME/zookeeper/logs

# start
./zookeeper/bin/zkServer.sh start
./drill/bin/drillbit.sh start

# log
tail -f ./drill/log/drillbit.out