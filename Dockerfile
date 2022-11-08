FROM ruby:3.1.2

# Dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create User
RUN useradd -ms /bin/bash bombapatch
USER bombapatch
WORKDIR /home/bombapatch/app

COPY --chown=bombapatch Gemfile* /

RUN bundle

COPY --chown=bombapatch . .

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
