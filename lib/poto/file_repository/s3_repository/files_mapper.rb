require "poto/file_repository/s3_repository/file_mapper"

module Poto
  class FileRepository
    class S3Repository
      class FilesMapper
        attr_reader :objects, :bucket

        def initialize(objects, bucket)
          @objects = objects
          @bucket  = bucket
        end

        def files
          objects.contents.map do |object|
            FileMapper.new(object, bucket)
          end
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
