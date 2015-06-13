require "roar/representer"
require "roar/json"
require "roar/json/hal"
require "poto/helpers/url_helper"

module Poto
  module FileRepresenter
    include Roar::JSON::HAL
    include Roar::Hypermedia
    include Grape::Roar::Representer
    include UrlHelper

    property :name
    property :size

    link :proxy do
      proxy_url
    end

    link :file do
      file_url
    end
  end
end