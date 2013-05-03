# encoding: utf-8
#!/usr/bin/ruby

require "open-uri"
require "nokogiri"
require "sinatra"
require "json"
require 'net/http'

 class Trip
 	attr_accessor :id , :route_from , :route_to , :hour , :week_day 	

 	def to_s
 		"#{@id} , #{@route_from.encode("utf-8").lstrip} , #{@route_to.encode("utf-8").lstrip} , #{@hour.encode("utf-8").lstrip} , #{@week_day.encode("utf-8").lstrip}"
 	end

 	def to_hash
 		{:id => @id , :route_from => @route_from  , :route_to => @route_to , :hour => @hour , :week_day => @week_day }
 	end

 end

get '/' do
	erb :index
end

get '/trips.json' do
	content_type :json
	{:routes => routes}.to_json
end

get '/trips.xml' do
	content_type 'text/xml'
	#builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
	#	xml.send()
	#end
	#{:routes => routes}.to_xml
end


def routes
	begin		
		page = Nokogiri::HTML(open("http://www.costasultransportes.com.br/?p=horarios/index", :read_timeout => 10))
		#puts "Did you find something? #{page.errors.empty?}"		
 		if page.css("option")
 			trips = Array.new
	 		results = {}
	 		page.search('option').each{ |id|
				unless id.attr('value').empty?
					results[id.attr('value')] = id.content				
				end
			}
			if !results.empty?
				results.each{ |id,content|
					page = Nokogiri::HTML(open("http://www.costasultransportes.com.br/horarios/visualiza.php?local=#{id}", :read_timeout => 10))

					if page.css("a")
						#puts page.css("a")
						#puts "Cachoeiro de Itapemirim- Córrego dos Monos".split("-")
						page.search('a').each{ |hour|
							trip = Trip.new
							trip.id = id.gsub(" ","")							
							#if content.match('^-').("-")
								places = content.split(/\u002D/)
								trip.route_from = places[0].strip								
								trip.route_to = places[1].to_s.strip!					
							#end			
							
							trip.hour = hour.search('strong').text.to_s.gsub(" ","")				
							trip.week_day  = hour.xpath('text()').text.gsub(/\u00a0/, '').strip
							trips << trip.to_hash
						}
					else
						raise "can't find bus schedules."	
					end
					
				}
				if trips.empty?
					raise "can't find bus schedules."
				else
					return trips
				end				
			else
				raise "can't find bus routes"
			end
			#return trips
		else
			raise "Unable to access the site."
 		end
	rescue Timeout::Error => e
		puts "Timeout exception launched: #{e.message}"
		return {:error => 504 , :message => e.message}
	rescue OpenURI::HTTPError => e
		puts "URL Not Found: #{e.message}"
		return {:error => 404 , :message => e.message}
	rescue Exception => e
		puts "Some exception : #{e.message}"
		return {:error => 500 , :message => e.message}
	end


 		
 end