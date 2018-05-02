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
     
     school_details_url = school_profile_url.split("/")[1]
     school_details_html = open("http://profiles.dcps.dc.gov/DetailOverview_.aspx?school=#{school_details_url}")
     school_details_document = Nokogiri::HTML(school_details_html)
    
    school_profile_hash[:name] = school_hash[:name]
    school_profile_hash[:url] = school_profile_url
    school_profile_hash[:principal_name] = document.css(".infacis").text
    school_profile_hash[:principal_email] = document.css("#school_info").css("a")[2]["href"].split(":")[1]
    school_profile_hash[:address] = document.css("p").first.text
    school_profile_hash[:grades] = school_details_document.css("#grade_id").css("p")[0].text
    school_profile_hash
  end 
  
  #method for scraping details about an individual principal
  def self.scrape_principal_details(school_hash)
    school_profile_url = school_hash[:url]   
    principal_profile_hash = {}  
    html = open("http://profiles.dcps.dc.gov#{school_profile_url}")
    document = Nokogiri::HTML(html)
    
    principal_profile_hash[:principal_full_name] = document.css(".infacis").text
    principal_profile_hash[:url] = school_profile_url
    principal_profile_hash[:principal_email] = document.css("#school_info").css("a")[2]["href"].split(":")[1]
    principal_profile_hash[:first_name] = principal_profile_hash[:principal_email].split("@").first.split(".").first
    principal_profile_hash[:last_name] = principal_profile_hash[:principal_email].split("@").first.split(".").last
    
    principal_profile_hash
  end 
  
  #method to capture all schools with their details in one array
  def self.all_schools_with_details(school_page_url)
    array_of_all_schools = []
    schools_array = scrape_all_schools(school_page_url)
    schools_array.each do |school|
    array_of_all_schools << scrape_school_details(school)
    end 
    array_of_all_schools
  end
  
  #method to capture all principals with their details in one array
  def self.all_principals_with_details(school_page_url)
    array_of_all_principals = []
    principals_array = scrape_all_schools(school_page_url)
    principals_array.each do |principal|
    array_of_all_principals << scrape_principal_details(principal)
    end 
    array_of_all_principals
  end
  
  
  #test method so I don't scrape the whole site every time I'm writing a method for another class
   def self.school_test
     test_value = []     
     test_value << scrape_school_details({:name=>"Ballou High School", :url=>"/Aiton+Elementary+School"})
     test_value << scrape_school_details({:name=>"Aiton Elementary School", :url=>"/Aiton+Elementary+School"})
     test_value << scrape_school_details({:name=>"Barnard Elementary School", :url=>"/Barnard+Elementary+School"})
     test_value
   end 
   
     #test method so I don't scrape the whole site every time I'm writing a method for another class
   def self.principal_test
     test_value = []
     test_value << scrape_principal_details({:name=>"Aiton Elementary School", :url=>"/Ballou+High+School"})
     test_value << scrape_principal_details({:name=>"Ballou High School", :url=>"/Aiton+Elementary+School"})
     test_value << scrape_principal_details({:name=>"Barnard Elementary School", :url=>"/Barnard+Elementary+School"})
     test_value
   end 
  
end 