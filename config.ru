require "bundler/setup"
require "rack/hal_browser"
require "hal/index"
require "poto"

use Rack::HalBrowser::Redirect

run HAL::Index.new(self: { href: "/", app: Poto::API, title: "Index" })

HAL::Index.register_rel "files", href: "/files", title: "Files"
