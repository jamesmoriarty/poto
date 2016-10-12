[![Code Climate](https://codeclimate.com/github/jamesmoriarty/poto/badges/gpa.svg)](https://codeclimate.com/github/jamesmoriarty/poto) [![Test Coverage](https://codeclimate.com/github/jamesmoriarty/poto/badges/coverage.svg)](https://codeclimate.com/github/jamesmoriarty/poto/coverage) [![Build Status](https://travis-ci.org/jamesmoriarty/poto.svg?branch=master)](https://travis-ci.org/jamesmoriarty/poto)

# Poto

Turn your AWS S3 bucket into an image gallery.

![Demo GIF](/doc/Demo.gif "Demo GIF")

Example: https://aqueous-cliffs-6127.herokuapp.com/

## Poto::ImageProxy

The image resizing proxy is rack middleware and can be used standalone.

```ruby
require "poto"

# width  - max width in pixels.
# height - max height in pixels.
# src    - source image url.
#
# Examples
#
# GET /image_proxy?width=500&height=500&src=https%3A%2F%2Faqueous-cliffs-6127.herokuapp.com%3A443%2Fapi%2Ffiles%2FRGVhdGggVmFsbGV5LmpwZw%3D%3D%250A
map("/image_proxy") do
  run Poto::ImageProxy
end
```

## Poto::API

As well as the API - query and access the storage backend via hal+json.

```ruby
require "poto"

# Examples
#
# GET /files&per_page=9
# {
#     "_embedded": {
#         "files": [{
#             "name": "Abstract.jpg",
#             "size": 15198281,
#             "_links": {
#                 "file": {
#                     "href": "https://aqueous-cliffs-6127.herokuapp.com:443/api/files/QWJzdHJhY3QuanBn%0A"
#                 }
#             }
#         }]
#     },
#     "_links": {
#         "self": {
#             "href": "https://aqueous-cliffs-6127.herokuapp.com:443/api/files?page="
#         },
#         "next": {
#             "href": "https://aqueous-cliffs-6127.herokuapp.com:443/api/files?page=Death+Valley.jpg&per_page=9"
#         }
#     }
# }
backend = Poto::FileRepository::S3Repository.new(bucket: ENV["AWS_S3_BUCKET"])

map("/api") do
  run Poto::API.new(backend)
end
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
