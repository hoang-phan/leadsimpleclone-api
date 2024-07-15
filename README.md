# LeadSimple Clone API

## Development

### Setup

This is a straight-forward Rails app, clone it from git then you are ready to do the setup:

```sh
cp .env.sample .env
bundle install
bundle exec rails db:create db:migrate
```

### Server

To run the server on port `3000`:

```sh
bundle exec rails server
```

### Test

To run the test suite

```sh
bundle exec rspec
```
