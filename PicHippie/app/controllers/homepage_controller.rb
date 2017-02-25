class HomepageController < ApplicationController
	#before_action :get_json_data
	
	require 'json'
	require 'httparty'

	@@base_url = 'http://api.pexels.com/v1/search?query=girl'
	@@previous_url = ''
	 
	def index
		#retrieve_data_from_api(@@base_url)
		@image = Image.paginate(:page => params[:page], :per_page => 5).order('owner ASC')
	end

	def show
		@image = Image.find_by(:id => params[:id])
	end	

	private

	def get_json_data
	  begin
	  	file = File.read("public/index.json")
	  	data = JSON.parse(file)

		for pos in data['photos']
		    response = HTTParty.get(pos['url']).code.to_i
		   	logger.debug response
		   	if response == 200
			    Image.create(
			  		:owner => pos['photographer'],
			  		:url => pos['url'] )
		    end
		    File.delete("public/index.json")
		end    		
	  rescue Exception => e
	  end	
	end
	  
	def retrieve_data_from_api(base_url)
	 	begin
	 		if @@base_url != @@previous_url

		 		response = HTTParty.get(
		 				base_url,
	    				:headers => { 
	    					"Authorization" => Figaro.env.PEXELS_API_KEY
	    					})
		 		file = File.open("public/index.json", "w")
	  			file.write(response.to_json) 
		 		get_json_data
		 		@@previous_url = base_url
		 	end	
	 	rescue Exception => e
	 		logger.debug "exit at here"
	 	end
	end


end