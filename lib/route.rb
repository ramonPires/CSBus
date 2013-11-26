# encoding: utf-8
#!/usr/bin/ruby

class Route
 	attr_accessor :id , :from , :to , :hour , :day

 	def to_s
 		"#{@id} , #{@from.encode("utf-8").lstrip} , #{@to.encode("utf-8").lstrip} , #{@hour.encode("utf-8").lstrip} , #{@day.encode("utf-8").lstrip}"
 	end

 	def to_hash
 		{:id => @id , :from => @from  , :to => @to , :hour => @hour , :day => @day }
 	end
end