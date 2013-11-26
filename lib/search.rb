# encoding: utf-8
#!/usr/bin/ruby
require "json"
require "./lib/helpers"
require "./lib/route"
#require "open-uri"
#require "nokogiri"
class Search
	include Helpers
	def initialize(timeout = 10)
		@url_schedules = "http://www.costasultransportes.com.br/?p=horarios/index"
		@url_ids = "http://www.costasultransportes.com.br/horarios/visualiza.php?local="
		@timeout = timeout
		@routes = Array.new
	end

	def to_json
		self.to_routes.to_json
	end

    def routes
		@routes
	end
	
	def cities_id		
		page = search(@url_schedules)
		results = {}
		if page.css("option")
			page.search('option').each { |option| 
				unless option.attr('value').empty?
					results[option.attr('value').to_i] = option.content
				end
			}
		end
		results
	end

	def to_routes
		results = cities_id		
		if !results.empty?
			results.each { |id,content|
=begin
			puts "#{id} - #{content}"
			puts "#{@url_ids}#{id}"
=end								
				page = search("#{@url_ids}#{id}" )
				if page.css("a")					
						page.search('a').each{ |hour|
							route = Route.new
							route.id = id.to_s.gsub(" ","")
							places = content.split(/\u002D/)
							route.from = places[0].strip								
							route.to = places[1].to_s.strip!					
							route.hour = hour.search('strong').text.to_s.gsub(" ","")				
							route.day  = hour.xpath('text()').text.gsub(/\u00a0/, '').strip
							@routes << route.to_hash
						}						
				end				
			}
			#@routes.sort_by{|route| route[:id]}
		end
		@routes
	end
end