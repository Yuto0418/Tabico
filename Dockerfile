FROM ruby:2.6.3-buster
RUN apt-get update -qq && apt-get install -y nodejs

# yarnパッケージ管理ツールをインストール
# https://classic.yarnpkg.com/en/docs/install/#debian-stable
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

WORKDIR /tabico
COPY Gemfile /tabico/Gemfile
COPY Gemfile.lock /tabico/Gemfile.lock
RUN bundle install
COPY . /tabico/

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
