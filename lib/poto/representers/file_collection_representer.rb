require "roar/representer"
require "roar/json"
require "roar/json/hal"
require "poto/representers/file_representer"

module Poto
  module FileCollectionRepresenter
    include Roar::JSON::HAL
    include Roar::Hypermedia
    include Grape::Roar::Representer

    collection :files, extend: FileRepresenter, embedded: true

    link :self do |opts, helpers = opts[:env]["api.endpoint"]|
      helpers.url_for opts, "/files", page: helpers.page
    end

    link :next do |opts, helpers = opts[:env]["api.endpoint"]|
      helpers.url_for opts, "/files", page: next_page, per_page: helpers.per_page if next_page
    end
  end
end
