FROM ruby:2.7.4-alpine3.13 AS builder
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --path dep/vendor/bundle --without development test

FROM ruby:2.7.4-alpine3.13 AS production
WORKDIR /app
ADD . ./
COPY --from=builder /app/Gemfile /app/Gemfile.lock dep ./
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-p", "3000"]

FROM ruby:2.7.4-alpine3.13 AS development
WORKDIR /app
ADD . ./
COPY --from=builder /app/Gemfile /app/Gemfile.lock dep ./
RUN bundle install --with development test
VOLUME /app
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-p", "3000"]