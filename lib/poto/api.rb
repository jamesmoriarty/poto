require "grape"
require "grape/roar"
require "poto/helpers/url_helper"
require "poto/file_repository/proxy"
require "poto/file_repository/s3_repository"
require "poto/representers/file_representer"
require "poto/representers/file_collection_representer"

module Poto
  class API < Grape::API
    helpers UrlHelper

    content_type :json, "application/hal+json"
    format       :json
    formatter    :json, Grape::Formatter::Roar

    def initialize(backend)
      self.class.global_setting(:proxy, FileRepository::Proxy.new(backend))

      super()
    end

    resource :files do
      get do
        present global_setting(:proxy)
            .prefix(params[:prefix])
            .page(current_page)
            .per_page(current_per_page)
          .call,
          with: FileCollectionRepresenter
      end
    end
  end
end
