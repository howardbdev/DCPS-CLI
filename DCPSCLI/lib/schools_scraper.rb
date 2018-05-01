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
    schools_array
    end 
  
  #method for scraping details about an individual school
  def self.scrape_school_details(school_hash)
    school_profile_url = school_hash[:url]   
    school_profile_hash = {}   
    html = open("http://profiles.dcps.dc.gov#{school_profile_url}")
    document = Nokogiri::HTML(html)
    
    document.search("br").each do |n|
     n.replace(", ")
     end
    
    school_profile_hash[:name] = school_hash[:name]
    school_profile_hash[:url] = school_profile_url
    school_profile_hash[:principal_name] = document.css(".infacis").text
    school_profile_hash[:principal_email] = document.css("#school_info").css("a")[2]["href"].split(":")[1]
    school_profile_hash[:address] = document.css("p").first.text
    school_profile_hash[:grades] =
    binding.pry
  end 
  
end 

Scraper.scrape_school_details({:name=>"Aiton Elementary School", :url=>"/Aiton+Elementary+School"})
