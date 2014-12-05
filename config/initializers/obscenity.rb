# configuring the gem dictionary to allow certain words
Obscenity.configure do |config|
	config.blacklist = "config/blacklist.yml"
end