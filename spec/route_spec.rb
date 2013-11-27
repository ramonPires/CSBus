# encoding: utf-8
require "spec_helper"

describe  "Route" do
	before :each do
		@route = Route.new
		@route.id = 1
		@route.from = "Canto Feliz"
		@route.to = "Cachoeiro de Itapemirim"
		@route.hour = "07:00"
		@route.day = "Diário"
	end

	it "should return 1 for the route id equals 1" do
		@route.id.should eq(1)
	end

	it "the starting point of a route should be different from the final" do
		@route.from.should_not eql(@route.to)
	end
end