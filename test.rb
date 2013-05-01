# encoding: UTF-8
require "open-uri"
require "nokogiri"
require "./app"
result  = {}
doc = Nokogiri::HTML(open("http://www.costasultransportes.com.br/?p=horarios/index"))
doc.search('option').each{ |id|
	unless id.attr('value').empty?
		result[id.attr('value')] = id.content
	end
}
result.each{ |id,content|
	puts "|-----------------------------------------------------------------------------|"
	doc = Nokogiri::HTML(open("http://www.costasultransportes.com.br/horarios/visualiza.php?local=#{id}"))
	hours = {}
	doc.search('a').each{ |hour|
		places = content.split('-')
		puts "Hora: #{hour.search('strong').text} , Dias da semana: #{hour.xpath('text()')}"
		puts "Local: #{places[0]} à #{places[1]}  - Hora: #{hour.content}"
	}
	puts "|-----------------------------------------------------------------------------|"
}

trip = Trip.new
trip.hour = "10:00"
puts trip.route_from

# ruby -e "`gem list`.split(/$/).each { |line| puts `gem uninstall -Iax #{line.split(' ')[0]}` unless line.strip.empty? }"

require 'net/http'
Net::HTTP.start( 'www.caelum.com.br', 80 ) do |http|
print( http.get( '/' ).code )
end