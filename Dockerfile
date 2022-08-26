FROM ruby:3.1.2

ENV BUNDLE_VERSION 2.3.7
ENV APP /usr/src/app

RUN set -eux && \
    apt update -qq && \
    apt install -y build-essential \
    libpq-dev \
    sudo
RUN gem install bundler -v $BUNDLE_VERSION

RUN mkdir $APP
WORKDIR $APP

COPY Gemfile* $APP/
RUN bundle install

COPY . $APP/

# Add a script to be executed every time the container starts.
# COPY ./entrypoint.sh /usr/bin/
# ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["./bin/server-dev"]
