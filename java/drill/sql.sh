#!/bin/bash
exec $APP_HOME/drill/bin/sqlline -u "jdbc:drill:drillbit=localhost" "$@"
