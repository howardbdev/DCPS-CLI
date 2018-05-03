require 'pry'

class DCPSCLIcontroller
 
  #This method initializes the controller by scraping all of the DCPS school and principal profiles, creating objects for each of them, and matching schools to principals 
  def initialize(path = "http://profiles.dcps.dc.gov/")
    School.create_from_scraper(Scraper.school_test)
    Principal.create_from_scraper(Scraper.principal_test)
    School.match_principals
  end 
  
  def call
    puts "Welcome to the DCPS CLI!  What information would you like?"
    puts "To view a list of all schools in alphabetically order, enter \'list schools\'\."
    puts "To list all of all principals in alphabetical order, enter \'list principals\'\."
    puts "To search for a school by name, enter \'school search\'\."
    puts "To search for a school by grade, enter \'grade search\'\."
    puts "To search for a principal by name, enter \'principal search\'\."
    puts "To quit, type \'exit\'\."
    puts   "What would you like to do?"
    choice = gets.strip
 while choice != "exit"
   if choice == "list schools"
      School.view_schools_alphabetically
    elsif choice == "list principals"
      Principal.view_principals_alphabetically
    elsif choice == "school search"
      entry = gets.strip
      School.find_by_name(entry)
    elsif choice == "grade search"
      entry = gets.strip
      School.find_school_by_grade(entry)
    elsif choice == "principal search"
      entry = gets.strip
      School.find_by_name(entry)
    elsif choice == "grade search"
    end 
   choice = gets.strip
   end 
 end 
  
  
end 