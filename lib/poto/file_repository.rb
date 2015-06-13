require "poto/file_repository/s3_repository"

module Poto
  class FileRepository
    class << self
      def proxy
        S3Repository.new(ENV["AWS_S3_BUCKET"])
      end

      delegate :page, :per_page, :query, to: :proxy
    end
  end
end
