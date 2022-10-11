FROM ruby:3.1.2

ENV DATABASE_HOST=db
ENV DATABASE_USERNAME=postgres
ENV POSTGRES_PASSWORD=password

RUN mkdir /app
WORKDIR /app

EXPOSE 3000

COPY Gemfile .
COPY Gemfile.lock .
RUN gem update bundler
RUN bundle install

CMD rails server -b 0.0.0.0