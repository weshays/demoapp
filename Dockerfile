FROM ruby:3.2.1

RUN apt update -yqq
RUN apt-get install libvips-dev -yqq
RUN apt-get install build-essential libpq-dev postgresql-contrib vim -yqq
RUN apt-get install imagemagick libmagickcore-dev libmagickwand-dev -yqq
RUN apt-get -q clean
RUN rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

RUN mkdir -p /app
WORKDIR /app

RUN gem update --system
COPY Gemfile* ./
RUN gem install bundler
RUN bundle install

COPY . .
RUN bundle binstubs --all

RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]
