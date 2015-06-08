require "bundler/setup"
require "rack/hal_browser"
require "hal/index"
require "poto"

require "sinatra"
class MyApp < Sinatra::Base
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  get("/") do
    File.read(File.join('public', 'index.html'))
  end
end

use MyApp

use Rack::HalBrowser::Redirect
run HAL::Index.new(self: { href: "/api", app: Poto::API, title: "Index" })

HAL::Index.register_rel "files", href: "/api/files", title: "Files"
