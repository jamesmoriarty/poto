$LOAD_PATH.unshift File.dirname(__FILE__)

require "active_support"
require "active_support/core_ext/object/to_param"
require "active_support/core_ext/object/try"
require "poto/version"
require "poto/api"
require "poto/image_proxy"
require "poto/app"

module Poto; end
