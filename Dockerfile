FROM ruby:3.1.2

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       vim

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./Gemfile /app/Gemfile 
ADD ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
