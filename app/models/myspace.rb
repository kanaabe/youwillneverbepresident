class Myspace 
  require 'rubygems'
  require 'mechanize'
  require 'open-uri'
  require 'nokogiri'

  def initialize(old_email)
    @old_email = old_email
  end

  def scrape_myspace_for_profile_photo
    mechanize = Mechanize.new
    page = mechanize.get("https://myspace.com/search/people?q=#{@old_email}")
    profile_page = page.links[20].click
    profile_page.links[0].attributes.search("img").first.attributes["src"].value
  end
end
