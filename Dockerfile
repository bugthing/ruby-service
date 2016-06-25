FROM alpine
MAINTAINER Ben Martin <benjamin247365@hotmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base libffi-dev
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app
RUN cp .env.sample .env

CMD dotenv ./bin/service
