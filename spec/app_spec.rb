require 'spec_helper'

describe "Sinatra App" do

  it "should respond to GET" do
    get '/'
        last_response.status.should be(200)
  end

  it "should respond as json to /routes.json " do
  	get "/routes.json"
  		last_response.content_type.should eq("application/json;charset=utf-8")
  end

end

