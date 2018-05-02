require_relative "scraper"
require_relative "principals"
require "pry"

class School
  attr_accessor :name, :principal, :url, :address, :grades, :grade_range
  @@all = []
  
    def initialize(school_hash)
       school_hash.each do |key, value| 
         self.instance_variable_set("@#{key}".to_sym, value)
      end
      self.turn_grade_range_into_grades
      @@all << self 
    end 
    
    def self.all 
      @@all
    end 
  
    def self.create_from_scraper(schools_array)  
      schools_array.each do |school|
        School.new(school)
      end
    end 
    
    def self.match_principals
      @@all.each do |school|
        Principal.all.each do |principal|
          if principal.url == school.url 
            school.principal = principal
            principal.school = school
          end 
        end 
      end 
    end 
   
    def turn_grade_range_into_grades
      lowest_grade_string = @grades.split("-")[0]
      highest_grade_string = @grades.split("-")[1]
      
      if lowest_grade_string == "PK3"
        lowest_grade = -2 
      elsif lowest_grade_string == "PK4"
        lowest_grade = -1 
      elsif lowest_grade_string == "K"
        lowest_grade = 0
      elsif lowest_grade_string == "Adult" 
        lowest_grade = 13 
      else 
        lowest_grade = lowest_grade_string.scan(/\d+/).join.to_i
      end 
      
      if highest_grade_string == "Adult"
        highest_grade = 13 
      else 
        highest_grade = highest_grade_string.scan(/\d+/).join.to_i
      end 
      
      @grade_range = Array(lowest_grade..highest_grade)
    end 
  
    def self.view_schools_alphabetically
      alphabetical_schools = @@all.sort_by {|school| school.name}
      alphabetical_schools.each do |school|
        puts school.name
      end 
    end 
    
    def self.find_school_by_name
    end 
    
    def self.find_school_by_principal
    end 
    
    def self.find_school_by_grade
    end 
    
    def view_school_details
    end 
  
end 

School.create_from_scraper(Scraper.school_test)
Principal.create_from_scraper(Scraper.principal_test)
School.match_principals
School.view_schools_alphabetically

