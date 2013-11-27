require 'spec_helper'

describe "CSBus App" do

	
  it "should respond with success when access \"/\" " do
    get '/'
        last_response.status.should be(200)
  end

  it "should respond as json to /routes.json " do
  	get "/routes.json"
  		last_response.content_type.should eq("application/json;charset=utf-8")
  end

end

