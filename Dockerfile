FROM alpine:3.10

ENV DOCKER_VERSION 17.09.0-ce

# We get curl so that we can avoid a separate ADD to fetch the Docker binary, and then we'll remove it
RUN apk --no-cache add bash curl \
  && cd /tmp/ \
  && curl -sSL -O https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
  && tar zxf docker-${DOCKER_VERSION}.tgz \
  && mv $(find -name 'docker' -type f) /usr/local/bin/ \
  && apk del curl \
  && rm -rf /tmp/*

COPY ./docker-gc /docker-gc

VOLUME /var/lib/docker-gc

CMD ["/docker-gc"]
