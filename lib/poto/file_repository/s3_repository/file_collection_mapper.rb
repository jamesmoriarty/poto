require "poto/file_repository/s3_repository/file_mapper"
require "poto/file_repository/file_collection"

module Poto
  module FileRepository
    class S3Repository
      class FileCollectionMapper
        attr_reader :objects

        def initialize(objects)
          @objects = objects
        end

        def call
          FileCollection.new(files, page, next_page)
        end

        private

        def files
          objects.contents.map { |object| FileMapper.new(object).call }
        end

        def page
          objects.marker
        end

        def next_page
          files.last.try(:name)
        end
      end
    end
  end
end
