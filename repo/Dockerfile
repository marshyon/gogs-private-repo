
FROM debian
MAINTAINER JOn Brookes <marshyon@gmail.com>

WORKDIR /app

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -y && \
    apt-get install -y ca-certificates curl dropbear git openssh-client procps curl unzip && \
    curl https://dl.gogs.io/0.12.1/gogs_0.12.1_linux_armv7.zip --output gogs.zip && \
    unzip gogs.zip && \
    mkdir -p gogs/custom/conf && \
    mkdir -p gogs/data && \
    mkdir -p gogs/repositories && \
    chmod +x gogs/gogs

COPY custom/conf/app.ini gogs/custom/conf
   
ENTRYPOINT [ "gogs/gogs", "web" ]
   
   
