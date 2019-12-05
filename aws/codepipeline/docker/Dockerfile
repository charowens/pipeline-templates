FROM alpine:3.9

ARG NEW_USER_ID
ENV UID=12345
RUN adduser -S -u $UID builder builder


RUN apk add --no-cache make
RUN apk add --no-cache gcc
RUN apk add --no-cache g++
RUN apk add --no-cache go
RUN apk add --no-cache bash
RUN apk add --no-cache nodejs
RUN apk add --no-cache nodejs-npm
RUN npm config set unsafe-perm true
RUN apk add --no-cache git
RUN apk add --no-cache python py-pip && \
    pip install awscli==1.16.221
RUN apk add --no-cache curl unzip && \ 
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    ln -s ~/.tfenv/bin/* /usr/local/bin && \
    tfenv install 0.11.14 && \
    tfenv install 0.11.7 && \
    tfenv install 0.12.6 && \
    tfenv install 0.12.7 && \
    tfenv use 0.12.6
RUN apk add --no-cache jq
RUN apk add --no-cache zip
RUN apk add --no-cache openssh
RUN apk add --no-cache outils-md5
RUN apk add --no-cache curl
RUN apk add --no-cache openjdk8-jre
RUN apk add --no-cache jsonnet --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add --no-cache docker
RUN apk add --no-cache rsync openssh
RUN apk add --no-cache tar 

RUN mkdir /working && chown builder /working


USER builder

WORKDIR /working

RUN curl -LOk https://download.checkmarx.com/8.8.0/Plugins/CxConsolePlugin-8.80.0.zip
RUN mkdir -p /working/CxConsolePlugin-8.80.0
RUN chown -R builder /working/CxConsolePlugin-8.80.0
RUN unzip CxConsolePlugin-8.80.0.zip -d /working
RUN chmod a+x /working/CxConsolePlugin-8.80.0/runCxConsole.sh
RUN rm CxConsolePlugin-8.80.0.zip

ENV PATH ~/flyway-5.2.4:/go/bin:$PATH


