FROM ruby:2.5

WORKDIR /usr/src/app

COPY lib/butts/version.rb ./lib/butts/
COPY Gemfile Gemfile.lock butts.gemspec ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "irb"]
