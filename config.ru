require "bundler/setup"
require "rack/hal_browser"
require "hal/index"
require "poto"

use Rack::HalBrowser::Redirect

run HAL::Index.new(self: { href: "/api", app: Poto::API, title: "Index" })

HAL::Index.register_rel "files", href: "/api/files", title: "Files"
