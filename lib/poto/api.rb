require "grape"
require "grape/roar"
require "poto/helpers"
require "poto/file_repository/proxy"
require "poto/representers/file_representer"
require "poto/representers/file_collection_representer"

module Poto
  class API < Grape::API
    helpers Helpers

    content_type :json, "application/hal+json"
    format       :json
    formatter    :json, Grape::Formatter::Roar

    resource :files do
      get do
        present global_setting(:proxy).prefix(prefix).page(page).per_page(per_page).all, with: FileCollectionRepresenter
      end

      route_param :id do
        get do
          redirect global_setting(:proxy).url(params[:id])
        end
      end
    end

    def self.configure(repository:)
      global_setting(:proxy, FileRepository::Proxy.new(repository))

      new
    end
  end
end
