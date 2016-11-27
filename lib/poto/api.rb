require "grape"
require "grape/roar"
require "poto/file_repository/proxy"
require "poto/representers/file_representer"
require "poto/representers/file_collection_representer"

module Poto
  class API < Grape::API
    content_type :json, "application/hal+json"
    format       :json
    formatter    :json, Grape::Formatter::Roar

    resource :files do
      get do
        present global_setting(:proxy).prefix(prefix).page(page).per_page(per_page).all, with: FileCollectionRepresenter
      end

      route_param :id do
        get do
          redirect global_setting(:proxy).url(id)
        end
      end
    end

    helpers do
      def url_for(opts, path, query = {})
        request = Grape::Request.new(opts[:env])

        URI::Generic.build(
          host:   request.host,
          port:   request.port,
          path:   File.join(opts[:env]["SCRIPT_NAME"], path),
          query:  query.to_param,
          scheme: request.scheme
        ).to_s.gsub(/\?$/, "")
      end

      def id
        URI.unescape(Base64.decode64(params[:id]))
      end

      def prefix
        params[:prefix]
      end

      def page
        params[:page]
      end

      def per_page
        params.fetch(:per_page, 25).to_i
      end
    end

    def self.configure(repository:)
      global_setting(:proxy, FileRepository::Proxy.new(repository))

      new
    end
  end
end
