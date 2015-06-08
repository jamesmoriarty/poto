require "sinatra"

module Poto
  class App < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "..", "..", "public")

    get("/") do
      File.read(File.join("public", "index.html"))
    end
  end
end
