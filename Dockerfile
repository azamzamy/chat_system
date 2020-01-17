FROM ruby:2.6.0
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs
RUN mkdir /chat_system
WORKDIR /chat_system
COPY Gemfile /chat_system/Gemfile
COPY Gemfile.lock /chat_system/Gemfile.lock
RUN bundle install
COPY . /chat_system
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]