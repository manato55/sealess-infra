FROM nginx:1.18-alpine
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=Asia/Tokyo

RUN apk update && \
  mkdir -p /work/backend/public && \
  touch /work/backend/public/index.php

COPY ./default.conf /etc/nginx/conf.d/default.conf

WORKDIR /work/backend/public
