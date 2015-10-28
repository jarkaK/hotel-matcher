# Hotel matcher
## Prerequisities

- ruby installed (ideally version > 2.0)

## Setup

Install rvm

Run bundle
```bash
bundle install
```

## Using

To find urls of a hotel run the gem from a command line

```bash
./bin/hotel-matcher hotel-name
```

## Development

### Running tests

Tests (rspec) can be ran from command line

```bash
rspec spec
```

### Improvements
Following improvements could be implementes:

- use official APIs of tripadvisor/booking/holidaycheck instead of parsing responses that can possibly change
- check the returned list of hotels and check if the first hotel is really the requested one
- implement real messaging system (sidekiQ - simple, RabbitMQ - more complex, supported by many languages)
- matching in batches (support of multiple arguments)
- documentation & rdoc generation
- storing results in database
- support logger configuration from other appss
