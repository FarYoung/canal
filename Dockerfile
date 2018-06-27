FROM openjdk:8-jre-alpine
MAINTAINER faryoung@qq.com

ENV CANAL_VERSION=1.0.25

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add file which bash

ADD https://github.com/alibaba/canal/releases/download/v${CANAL_VERSION}/canal.deployer-${CANAL_VERSION}.tar.gz /tmp/canal/
#ADD canal.deployer-${CANAL_VERSION}.tar.gz /tmp/canal/
RUN mv /tmp/canal /

WORKDIR /canal
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

EXPOSE 11111

ENV PATH /canal:$PATH
ENTRYPOINT ["entrypoint.sh"]
