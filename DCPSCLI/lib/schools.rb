class School
  attr_accessor :principal, :url, :address, :grades
  @@all = []
  
  def initialize(principal, url, address, grades)
    @principal = principal
    @url = url
    @address = address
    @grades = grades
    @@all << self 
  end 
  
  def make_schools_from_scraper(schools_hash)
  end 
  
  def school_details_from_scraper(school_details_hash)
  end 
  
  
end 