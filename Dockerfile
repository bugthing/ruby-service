FROM alpine:3.9.4
MAINTAINER Ben Martin <benjamin247365@hotmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base libffi-dev
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler
ENV TEST_PACKAGES rabbitmq-c rabbitmq-c-utils mongodb-tools vim

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES \
            $RUBY_PACKAGES  \
            $TEST_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle update --bundler

COPY . /usr/app
RUN cp .env.sample .env

CMD ./bin/service
