require "open-uri"
require "nokogiri"
module Helpers
	def search(url, timeout=10)	
		begin
			return Nokogiri::HTML(open(url))		
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

end