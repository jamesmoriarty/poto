module Poto
  module UrlHelper
    def url_for(opts, path, query = {})
      request = Grape::Request.new(opts[:env])

      URI::Generic.build(
        host:  request.host,
        port:  request.port,
        path:  File.join(opts[:env]["SCRIPT_NAME"], path),
        query: query.to_param
      ).to_s.gsub(/\?$/, "")
    end

    def current_page
      params.fetch(:page, nil)
    end

    def current_per_page
      params.fetch(:per_page, 25).to_i
    end
  end
end
