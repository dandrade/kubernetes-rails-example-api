FROM ruby:3.1.1-alpine

# RUN apt clean && apt update && apt install -y nodejs yarn postgresql-client
RUN apk add --update --no-cache --virtual run-dependencies \
build-base \
mysql-client \
mysql-dev \
yarn \
git \
tzdata \
libpq \
less \
ncurses \
nodejs \
tzdata \
&& rm -rf /var/cache/apk/*

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

# RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
