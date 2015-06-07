require "poto/file_repository/s3_proxy"

module Poto
  class FileRepository
    class << self
      def proxy
        S3Proxy.new
      end

      delegate :page, :per_page, :query, to: :proxy
    end
  end
end
