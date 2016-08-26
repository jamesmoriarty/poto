require "poto/file_repository/s3_repository/file_mapper"

module Poto
  module FileRepository
    class S3Repository
      class FileCollectionMapper
        attr_reader :objects

        def initialize(objects)
          @objects = objects
        end

        def files
          objects.contents.map { |object| FileMapper.new(object) }
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
