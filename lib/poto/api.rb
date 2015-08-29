require "grape"
require "grape/roar"
require "poto/helpers/url_helper"
require "poto/file_repository"
require "poto/representers/file_representer"
require "poto/representers/files_representer"

module Poto
  class API < Grape::API
    helpers UrlHelper

    content_type :json, "application/hal+json"
    format       :json
    formatter    :json, Grape::Formatter::Roar

    resource :files do
      get do
        present FileRepository.new(FileRepository::S3Repository, bucket: ENV["AWS_S3_BUCKET"])
            .prefix(params[:prefix])
            .page(current_page)
            .per_page(current_per_page)
          .call,
          with: FilesRepresenter
      end
    end
  end
end
