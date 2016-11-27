require "base64"

require "poto/file_repository/file_collection"
require "poto/file_repository/google/cloud/storage/file_mapper"

module Poto
  module FileRepository
    module Google
      module Cloud
        class Storage
          class FileCollectionMapper
            attr_reader :page

            def initialize(files, page)
              @files = files
              @page  = page
            end

            def call
              FileCollection.new(files, page, next_page)
            end

            private

            def files
              @files.map { |file| FileMapper.new(file).call }
            end

            def next_page
              @files.token
            end
          end
        end
      end
    end
  end
end
