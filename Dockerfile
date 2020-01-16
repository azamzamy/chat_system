FROM ruby:2.6.0
# RUN apt-get update && apt-get install -y \
#   build-essential \
#   nodejs
# RUN mkdir /chat_system
# WORKDIR /chat_system
# COPY Gemfile /chat_system/Gemfile
# COPY Gemfile.lock /chat_system/Gemfile.lock
# RUN bundle install
# COPY . /chat_system

# # Add a script to be executed every time the container starts.
# # COPY entrypoint.sh /usr/bin/
# # RUN chmod +x /usr/bin/entrypoint.sh
# # ENTRYPOINT ["entrypoint.sh"]
# # EXPOSE 3000

# # Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /chat_system
WORKDIR /chat_system

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# COPY docker-entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/docker-entrypoint.sh
# ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]