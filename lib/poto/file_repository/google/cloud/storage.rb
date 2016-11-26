require "base64"
require "google/cloud/storage"

require "poto/file_repository/google/cloud/storage/file_collection_mapper"

module Poto
  module FileRepository
    module Google
      module Cloud
        class Storage
          attr_reader :bucket, :client

          def initialize(bucket:, client:)
            @client = client
            @bucket = client.bucket(bucket)
          end

          def url(id)
            bucket.file(decode(id)).signed_url
          end

          def all(prefix:, page:, per_page:)
            files = bucket.files(prefix: prefix, token: page, max: per_page)

            FileCollectionMapper.new(files, page).call
          end

          private

          def decode(value)
            URI.unescape(Base64.decode64(value))
          end
        end
      end
    end
  end
end
