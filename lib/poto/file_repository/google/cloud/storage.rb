require 'base64'
require 'google/cloud/storage'

require 'poto/file_repository/google/cloud/storage/file_collection_mapper'

module Poto
  module FileRepository
    module Google
      module Cloud
        class Storage
          attr_reader :client

          def initialize(client:)
            @client = client
          end

          def url(id)
            client.file(id).signed_url
          end

          def all(prefix:, page:, per_page:)
            files = client.files(
              prefix: prefix,
              token:  page,
              max:    per_page
            )

            FileCollectionMapper.new(files, page).call
          end
        end
      end
    end
  end
end
