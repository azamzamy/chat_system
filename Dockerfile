FROM ruby:2.4.1
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs
RUN mkdir /chat_system
WORKDIR /chat_system
COPY Gemfile /chat_system/Gemfile
COPY Gemfile.lock /chat_system/Gemfile.lock
RUN gem install bundler -v 2.0.1
ENV BUNDLER_VERSION='2.0.2'
RUN gem install bundler --no-document -v '2.0.2'
# RUN gem update --system
RUN bundle install

COPY . /chat_system
EXPOSE 3000

ENTRYPOINT ["sh", "./config/docker/startup.sh"]


