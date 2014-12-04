class FacebookDirt

	def initialize(auth)
		@token = auth
	end

	def obscene_statuses
		# Development
		#response = JSON.parse(IO.read("app/test_data/kana_data.json"))
		
		# Production
		@facebook = Koala::Facebook::API.new(@token)
  	response = @facebook.get_object("me/statuses?limit=100")
  	statuses = []
  	while response != []
  		statuses << get_statuses_for_a_page(response)
  		response = response.next_page
  	end
		statuses.flatten
	end

	def get_statuses_for_a_page(response)
		statuses = []
		response.each do |res|
			if Obscenity.profane?(res["message"])
				statuses << res["message"]
			end
		end
		statuses
	end


end