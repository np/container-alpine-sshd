FROM alpine:3.4

LABEL edu.harvard.fas.rc.origin="sickp/alpine-sshd:latest"

RUN apk add --no-cache openssh bash rsync

ENV USERNAME=transfer
ENV PASSWORD='vKv+dMvCf2jU3bRjXauB/Q'
ENV GROUP=grid
ENV UID=1004
ENV GID=20031
ENV PUBKEY=''
ENV ROOT_PASSWORD='Fu+yUSOw6MEx++n4httgtQ'
ENV MOTD=''


RUN sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config && \
    rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
