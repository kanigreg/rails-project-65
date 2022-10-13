install:
	bundle install --without production development
	yarn install

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views

setup:
	bin/setup

test:
	bin/rails test

.PHONY: test
