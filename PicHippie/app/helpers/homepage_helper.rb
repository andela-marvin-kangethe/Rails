module HomepageHelper
	def get_image(url)
		id = ''
		for values in url.scan(/\d/).map(&:to_i)
			id+=values.to_s
		end
		image_url = "https://images.pexels.com/photos/#{id}/pexels-photo-#{id}.jpeg"
	end
end
