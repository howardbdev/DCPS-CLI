require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  
  #method for scraping the names of all the schools from the DCPS page
  def self.scrape_all_schools(school_page_url)
    html = open(school_page_url)
    document = Nokogiri::HTML(html)
    schools_array = []
    
    document.css(".schoolname").each do |school|
      temp_hash = Hash.new 
      temp_hash[:name] = school.text
      temp_hash[:url] = school["href"]
      schools_array << temp_hash
    end 
    binding.pry
    end 
  
  #method for scraping details about an individual school
  def self.scrape_school_details(school_profile_url)
    html = open(school_profile_url)
    document = Nokogiri::HTML(html)
    school_profile_hash = []
    
    school_profile_hash[:name] = 
    school_profile_hash[:url] =
    school_profile_hash[:principal_name] = 
    school_profile_hash[:address] = 
    school_profile_hash[:grades] =
    
  end 
  
end 

Scraper.scrape_all_schools("http://profiles.dcps.dc.gov")