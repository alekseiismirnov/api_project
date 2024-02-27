FROM docker.io/library/ruby:3.0.0-alpine

RUN apk update && \
  apk add --update --virtual \
  runtime-deps \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  readline \
  build-base \
  postgresql-dev \
  sqlite-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  git \
  tzdata \
  vips \
  && rm -rf /var/cache/apk/*

ARG USERNAME
ARG GROUPNAME
ARG USERID
ARG GROUPID

COPY run_rails.sh /usr/local/bin
RUN chmod +x /usr/local/bin/run_rails.sh

WORKDIR /app/quotes

RUN echo '***' && \
    addgroup -g $GROUPID $GROUPNAME && \
    adduser -S -u $USERID -G $GROUPNAME  -h /home/$USERNAME -s /bin/sh $USERNAME && \
    echo "$USERNAME     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/$USERNAME && \
    mkdir -p /app/quotes && \
    touch /app/quotes/trash.me && \
    echo "export PATH=$PATH:/home/$USERNAME/.local/share/gem/ruby/3.0.0/bin" >> /home/$USERNAME/.profile && \
    echo 'gem: --user-install --env-shebang --no-rdoc --no-ri' >> /home/$USERNAME/.gemrc && \
    chmod 700 /home/$USERNAME && \
    chown -R $USERNAME:$GROUPNAME /home/$USERNAME && \
    chown -R $USERNAME:$GROUPNAME /app
USER $USERNAME

ENTRYPOINT ["run_rails.sh"]
EXPOSE 3000

