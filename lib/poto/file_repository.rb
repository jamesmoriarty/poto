require "poto/s3_lazy_proxy"

module Poto

  class FileRepository
    class Files < Struct.new(:files, :page, :next_page); end
    class File < Struct.new(:name, :size, :file_url); end

    class << self
      def proxy
        S3LazyProxy.new
      end

      delegate :page, :per_page, :query, to: :proxy
    end
  end
end
