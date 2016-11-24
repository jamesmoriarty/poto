module Poto
  module Helpers
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
end