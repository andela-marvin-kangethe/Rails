module HomepageHelper
	require 'httparty'
	
	def get_image(url)
		image_url = url[/[\w]+(-)[\w]+/].gsub('-', ' ')
	end	

	def check_image_link(url)
		response = HTTParty.get(url).code.to_i
	    if response == 200
	    	true
		end
	end
end