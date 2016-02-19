require "rack/test"

include Rack::Test::Methods

def app
  described_class
end
