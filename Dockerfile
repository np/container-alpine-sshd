FROM sickp/alpine-sshd:latest

RUN apk add --no-cache bash rsync

ENV USERNAME=transfer
ENV PASSWORD='vKv+dMvCf2jU3bRjXauB/Q'
ENV GROUP=grid
ENV UID=1004
ENV GID=20031
ENV PUBKEY=''
ENV ROOT_PASSWORD='Fu+yUSOw6MEx++n4httgtQ'


RUN passwd -d root && \
    echo "root:$ROOT_PASSWORD" | chpasswd && \
    addgroup -g $GID $GROUP &&\
    adduser -D -h /home/$USERNAME -s /bin/bash -u $UID -G $GROUP $USERNAME && \
    mkdir -p /home/$USER/.ssh && \
    echo "$USER:PASSWORD" | chpasswd && \
    sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config && \
    echo "AllowUsers $USER" >> /etc/ssh/sshd_config

RUN chown -Rf $USER:$USER /home/$USER/.ssh/ && \
    chmod 0700 /home/$USER/.ssh/ && \
    echo $PUBKEY > /home/$USER/.ssh/authorized_keys && \
    chmod 0600 /home/$USER/.ssh/authorized_keys
