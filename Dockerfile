FROM ruby:3.4

# Uncomment the following line if a Gemfile.lock is used
# RUN bundle config --global frozen 1

WORKDIR /usr/src/app
EXPOSE 4567

COPY . /usr/src/app
RUN bundle install

CMD ruby janky_api.rb -o 0.0.0.0
