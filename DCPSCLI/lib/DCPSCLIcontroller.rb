require_relative '../config/environment'

# require_relative "scraper"
# require_relative "principals"
# require_relative "concerns/searchandsortmethods"
# require_relative "schools"
require "pry"


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
    puts "To list all of all principals with their email addresses, enter \'list emails\'\."
    puts "To search for a school by name, enter \'school search\'\."
    puts "To search for a school by grade, enter \'grade search\'\."
    puts "To search for a principal by name, enter \'principal search\'\."
    puts "To quit, type \'exit\'\."
    puts "\n"
    puts   "What would you like to do?"
    choice = gets.strip
    puts "\n"
 while choice != "exit"
   if choice == "list schools"
      School.view_schools_alphabetically
      more_information
    elsif choice == "list principals"
      Principal.view_principals_alphabetically
      more_information
    elsif choice == "list emails"
      Principal.view_all_principals_with_email_addresses
      more_information
    elsif choice == "school search"
    puts "Please enter a search value"
      entry = gets.strip
      School.find_by_name(entry)
      more_information
    elsif choice == "grade search"
    puts "Please enter a search value"
      entry = gets.strip
      School.find_school_by_grade(entry)
      more_information
    elsif choice == "principal search"
    puts "Please enter a search value"
      entry = gets.strip
      Principal.find_by_name(entry)
      more_information
    end 
   choice = gets.strip
   end 
 end 
  
  def more_information
     puts "\n"
     puts "For more information on a #{self.class.name.downcase}, please enter an item number or enter \'return\' to return to the menu"
     entry = gets.strip
      if entry.downcase == "return"
        call
      elsif entry.match(/\d+/)
        details(entry.to_i)
      else
        puts "I'm sorry, that is not a valid entry."
        more_information 
     end 
   end 
   
   def details(entry)
     
     self.class.view_details
   end 
  
end 

DCPSCLIcontroller.new.call