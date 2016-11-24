require "roar/representer"
require "roar/json"
require "roar/json/hal"

module Poto
  module FileRepresenter
    include Roar::JSON::HAL
    include Roar::Hypermedia
    include Grape::Roar::Representer

    property :name
    property :size

    link :file do |opts, helpers = opts[:env]["api.endpoint"]|
      helpers.url_for opts, "/files/#{id}"
    end
  end
end
