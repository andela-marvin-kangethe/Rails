module HomepageHelper
	require 'httparty'
	
	def get_image(url)
		id = ''
		for values in url.scan(/\d/).map(&:to_i)
			id+=values.to_s
		end	
		image_url = "https://images.pexels.com/photos/#{id}/pexels-photo-#{id}.jpeg"
	end	

	def check_image_link(url)
		response = HTTParty.get(url).code.to_i
	    if response == 200
	    	true
		end
	end
end