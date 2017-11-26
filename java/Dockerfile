FROM java:8

# auther
MAINTAINER mircode

# app conf
ARG app=app
ARG APP_HOME=/opt/app

# env conf
ENV APP_HOME $APP_HOME

# mkdir
RUN mkdir -p $APP_HOME

# work dir
WORKDIR $APP_HOME

# install
COPY ./$app/ ./

# install tools
RUN apt-get update && apt-get install vim tree -y

# start
CMD ["./start.sh"]