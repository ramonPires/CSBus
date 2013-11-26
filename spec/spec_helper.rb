require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rack/test'
 
def app
	Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end