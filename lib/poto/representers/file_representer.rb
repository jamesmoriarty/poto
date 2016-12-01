require 'base64'
require 'roar/representer'
require 'roar/json'
require 'roar/json/hal'

module Poto
  module FileRepresenter
    include Roar::JSON::HAL
    include Roar::Hypermedia
    include Grape::Roar::Representer

    property :name
    property :size

    link :file do |opts, helpers = opts[:env]['api.endpoint']|
      helpers.url_for opts, '/files/' + Base64.urlsafe_encode64(id)
    end
  end
end
