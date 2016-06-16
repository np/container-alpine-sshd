FROM sickp/alpine-sshd:latest
RUN apk add --no-cache bash rsync
ENV ROOT_PASSWORD uph#oh0KaiChuch8aetacaew
ENV USERNAME user1
ENV PASSWORD aeh9Io~liesie?zaz;ah8tac
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash $USERNAME && \
  passwd -u $USERNAME && \
  chown -R $USERNAME:$PASSWORD /home/$USERNAME && \
  echo "root:$ROOT_PASSWORD" | chpasswd
