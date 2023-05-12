FROM ruby:slim-bullseye

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN npm install --global yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.4
ADD Gemfile* $APP_HOME/
RUN bundle install -j 5

ENV RAILS_ENV=production
RUN yarn install --check-files
ADD . $APP_HOME
EXPOSE 3000
CMD bundle exec puma --config config/puma.rb -e production -b 0.0.0.0
