require "grape"
require "grape/roar"
require "poto/helpers/url_helper"
require "poto/file_repository/proxy"
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
            .query(params[:query])
            .page(current_page)
            .per_page(current_per_page)
          .all,
          with: FileCollectionRepresenter
      end

      route_param :id do
        get do
          redirect global_setting(:proxy).url(decode(params[:id]))
        end
      end
    end
  end
end
