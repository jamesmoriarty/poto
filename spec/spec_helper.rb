$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

require 'poto'
