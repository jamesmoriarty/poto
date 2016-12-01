Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'poto'
