FROM ruby:2.3.0-alpine

ENV PORT                  80
ENV AWS_ACCESS_KEY_ID     REQUIRED
ENV AWS_SECRET_ACCESS_KEY REQUIRED
ENV AWS_REGION            REQUIRED
ENV AWS_S3_BUCKET         REQUIRED

RUN apk add --no-cache git imagemagick make gcc libc-dev libxml2-dev libxslt-dev libffi-dev yaml-dev openssl-dev zlib-dev readline-dev
ADD . .
RUN bundle install --jobs $(expr $(cat /proc/cpuinfo | grep processor | wc -l) - 1) --retry 3

CMD bin/poto
