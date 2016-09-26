FROM sickp/alpine-sshd:latest

RUN apk add --no-cache bash rsync

ARG USER=transfer

ARG PASSWORD='vKv+dMvCf2jU3bRjXauB/Q'

ARG ROOT_PASSWORD='Fu+yUSOw6MEx++n4httgtQ'


RUN passwd -d root && \
    echo "root:$ROOT_PASSWORD" | chpasswd && \
    adduser -D -h /home/$USER -s /bin/bash $USER && \
    mkdir -p /home/$USER/.ssh && \
    echo "$USER:PASSWORD" | chpasswd && \
    sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/#MaxAuthTries.*/MaxAuthTries\ 3/ /etc/ssh/sshd_config && \
    sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config

COPY ./id_transfer.pub /home/$USER/.ssh/authorized_keys

RUN chown -Rf $USER:$USER /home/$USER/.ssh/ && \
    chmod 0700 /home/$USER/.ssh/ && \
    chmod 0600 /home/$USER/.ssh/authorized_keys
