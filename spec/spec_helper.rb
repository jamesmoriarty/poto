require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |file| require file }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "poto"
require "poto/file_repository/s3_repository"
