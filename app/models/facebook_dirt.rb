class FacebookDirt
	# attr_accessor :oauth

	# def initialize
	# 	@oauth = initialize_facebook_client
	# end



	# private
	# 	def initialize_facebook_client
	# 		Koala::Facebook::OAuth.class_eval do
	# 		  def initialize_with_default_settings(*args)
	# 		    raise "application id and/or secret are not specified in the envrionment" unless ENV['FB_APP_ID'] && ENV['FB_SECRET_KEY']
	# 		    initialize_without_default_settings(ENV['FB_APP_ID'].to_s, ENV['FB_SECRET_KEY'].to_s, args.first)
	# 		  end 

	# 		  alias_method_chain :initialize, :default_settings 
	# 		end
	# 	end

end