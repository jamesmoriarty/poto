require "grape"
require "grape/roar"
require "poto/helpers/url_helper"
require "poto/file_repository"
require "poto/representers/file_representer"
require "poto/representers/files_representer"

module Poto
  class API < Grape::API
    helpers UrlHelper

    content_type :json, 'application/hal+json'
    format       :json
    formatter    :json, Grape::Formatter::Roar

    resource :files do
      get do
        present FileRepository.page(current_page).per_page(current_per_page).call, with: FilesRepresenter
      end

      route_param :id do
        get do
          present FileRepository.find(params[:id]), with: FileRepresenter
        end
      end
    end
  end
end
