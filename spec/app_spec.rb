require 'spec_helper'

describe "Sinatra App" do

  it "should respond to GET" do
    get '/'
        last_response.status.should be(200)
  end

end