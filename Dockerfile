FROM ruby:2.7.4-alpine3.13 AS builder
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN apk add --update \
  build-base \
  mysql-dev \
  tzdata \
  && rm -rf /var/cache/apk/*
RUN bundle install --path dep/vendor/bundle --without development test

FROM ruby:2.7.4-alpine3.13 AS production
WORKDIR /app
ADD . ./
COPY --from=builder /app/Gemfile /app/Gemfile.lock /app/dep ./
RUN apk add --update \
  build-base \
  mysql-dev \
  tzdata \
  && rm -rf /var/cache/apk/*
RUN bundle install --without development test
EXPOSE $PORT
CMD ./docker-entrypoint.sh

FROM ruby:2.7.4-alpine3.13 AS development
VOLUME /app
WORKDIR /app
ADD . ./
COPY --from=builder /app/Gemfile /app/Gemfile.lock /app/dep ./
RUN apk add --update \
  build-base \
  mysql-dev \
  tzdata \
  && rm -rf /var/cache/apk/*
RUN bundle install --with development test
EXPOSE $PORT
CMD ./docker-entrypoint.sh