# Ping My Site

A simple CLI Pingdom-like written in ruby.

## How to use

### Git clone

> git clone https://github.com/cedricbousmanne/PingMySite.git

### Install required Gem

> bundle

### dotenv (.env)

Copy the ```.env_schema```file to ```.env```and fill it.
> cp .env_schema .env

### Run

> bin/ping-my-site ping http://google.com --expected-status-code 200  --follow-location false

### Options

* ```--expected-status-code XXX``` : define the expected HTTP status code (default: ```200```)
* ```--follow-location true```: allow CURL to follow HTTP redirection (default: false)

## Usecase

### Test HTTP status

> bin/ping-my-site ping http://google.com --expected-status-code 200

### Test HTTP redirection

> bin/ping-my-site ping http://mysite.be --expected-status-code 301 --follow-location false --expected-redirect-url http://www.mysite.be

## Troubleshooting

### Dotenv::Schema::ValidationError

Something is missing in your ```.env```file. Compare it to ```.env_schema```and be sure every constant is defined.

## Use with crontab

> * * * * * /bin/bash -l -c 'cd /path/to/ping-my-site/ && bundle exec bin/ping-my-site ping http://www.6x7asbl.be --expected-status-code 200 --follow-location false'

## Technologies

* [Dotenv Schema](https://github.com/mirakui/dotenv-schema)
* [Thor](http://whatisthor.com/)
* [Curb](https://github.com/taf2/curb)
* [Slack-Notifier](https://github.com/stevenosloan/slack-notifier)

## Foot Note

Coded with &#9829;, [Ruby](https://www.ruby-lang.org/) and [Vim](http://www.vim.org/). Made in Belgium.

