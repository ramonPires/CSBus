# encoding: utf-8
#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "sinatra"
require "./lib/search"

get '/' do
	erb :index
end

get '/routes.json' do
	content_type :json
	Search.new.to_json	
end
