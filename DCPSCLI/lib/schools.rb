require_relative "../lib/concerns/searchandsortmethods"

class School
  extend SearchAndSortMethods::ClassMethods
  include SearchAndSortMethods::InstanceMethods
  
  attr_accessor :name, :principal, :url, :address, :grades, :grade_range, :controller_session
  @@all = []
  
    def self.all
      @@all
    end

    #This initialize method for schools has extra steps to convert the scraped grades into an array and match principals with schools
    def initialize(hash)
      super
      self.turn_grade_range_into_grades
    end 
    
    #This method runs through the array of schools and matches them to their principal based on the URL
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
   
    #This method takes the scraped value of a school's grades and converts it to a range in an array so schools can be searched by grade
    def turn_grade_range_into_grades
      if @grades == nil
        lowest_grade = "none"
        highest_grade = "none"
      elsif @grades.downcase == "adult"
          lowest_grade = 13
          highest_grade = 13
      
      else 
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
    end 
      @grade_range = Array(lowest_grade..highest_grade)
    end 
  
    #This method puts the full list of schools alphabetically
    def self.view_schools_alphabetically
      alphabetical = self.all.sort_by {|item| item.name}
      alphabetical.each do |item|
        puts "#{alphabetical.index(item) + 1}. #{item.name}"
      end
      alphabetical
    end
    
   
    #This method allows you to enter a search term to find a school by grade
    def self.find_school_by_grade_entry
      puts "Please enter a search value"
      entry = gets.strip.downcase
      if entry == "pk3"
        grade_entry = -2
      elsif entry == "pk4"
        grade_entry = -1
      elsif entry == "k" || entry == "kindergarten"
       grade_entry = 0
      elsif entry == "adult" || entry == "a"
        grade_entry = 13
      elsif entry.scan(/\d+/)
        grade_entry = entry.scan(/\d+/)[0].to_i
        grade_entry -= 1
        if grade_entry > 12 || grade_entry < 1
          puts "That is not a valid entry."
          self.find_school_by_grade_entry
        end 
       else
         puts "That is not a valid entry."
         self.find_school_by_grade_entry
      end 
      grade_entry
    end 
    
    #This method searchs for a grade level and returns all schools whose grade ranges include that level
    def self.grade_level_search(grade_entry)
      school_names = []
      @@all.each do |school|
        if school.grade_range.include? grade_entry
        school_names << school 
       end 
  
     end 
    
      school_names.each do |school|
        puts "#{school_names.index(school) + 1}. School: #{school.name}, Grades: #{school.grades}"
     end
     school_names
    end
    
    #This method puts details about an individual school
    def view_details
      puts "Name: #{@name}"
      puts "Principal: #{@principal.name}"
      puts "Principal Email: #{@principal.email}"
      puts "Grades: #{@grades}"
      puts "Address: #{@address}"
      puts "School Profile: http://profiles.dcps.dc.gov#{@url}"
    end 
  
end 
