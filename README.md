[![Code Climate](https://codeclimate.com/github/jamesmoriarty/poto/badges/gpa.svg)](https://codeclimate.com/github/jamesmoriarty/poto) [![Test Coverage](https://codeclimate.com/github/jamesmoriarty/poto/badges/coverage.svg)](https://codeclimate.com/github/jamesmoriarty/poto/coverage) [![Build Status](https://travis-ci.org/jamesmoriarty/poto.svg?branch=master)](https://travis-ci.org/jamesmoriarty/poto)

# Poto

Turn your AWS S3 bucket into an image gallery. Example: https://aqueous-cliffs-6127.herokuapp.com/

## Poto::ImageProxy

The image resizing proxy is rack middleware and can be used standalone.

```ruby
require "poto"

# * width  - max width in pixels
# * height - max height in pixels
# * src    - source image url
#
# @example
#
# ?width=250&height=250&src=http%3A%2F%2Fexample.com%2Fimage.png
run Poto::ImageProxy
```

## Installation

    $ gem install poto

## Usage

    $ PORT=? AWS_ACCESS_KEY_ID=? AWS_SECRET_ACCESS_KEY=? AWS_REGION=? AWS_S3_BUCKET=? poto
    Puma 2.11.3 starting...
    * Min threads: 0, max threads: 16
    * Environment: development
    * Listening on tcp://0.0.0.0:9294

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/poto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
