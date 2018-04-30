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
  
  
  
end 