require "roar/representer"
require "roar/json"
require "roar/json/hal"
require "poto/helpers"

module Poto
  module FileRepresenter
    include Roar::JSON::HAL
    include Roar::Hypermedia
    include Grape::Roar::Representer
    include Poto::Helpers

    property :name
    property :size

    link :file do |opts|
      url_for opts, "/files/#{id}"
    end
  end
end
