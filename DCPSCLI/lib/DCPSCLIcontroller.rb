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
    @most_recent_array = []
    @most_recent_selection = ""
    
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
      upon_selection(School.view_schools_alphabetically)
    elsif choice == "list principals"
      upon_selection(Principal.view_principals_alphabetically)
    elsif choice == "list emails"
      upon_selection(Principal.view_all_principals_with_email_addresses)
    elsif choice == "school search"
    puts "Please enter a search value"
      entry = gets.strip
      upon_selection(School.find_by_name(entry))
    elsif choice == "grade search"
    puts "Please enter a search value"
      entry = gets.strip
      upon_selection(School.find_school_by_grade(entry))
    elsif choice == "principal search"
    puts "Please enter a search value"
      entry = gets.strip
      upon_selection(Principal.find_by_name(entry))
    end 
   choice = gets.strip
   end 
 end 
 
   def upon_selection(choice)
       choice
       @most_recent_array = choice
       @most_recent_selection = "#{choice}"
       more_information
    end 
       
  
  def more_information
     puts "\n"
     puts "For more information on a #{@most_recent_array[0].class.name.downcase}, please enter an item number or enter \'return\' to return to the menu"
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
     @most_recent_array[entry - 1].view_details
     next_choice
    end
    
    def next_choice
    puts "To return to the main menu, please enter \'menu\'.  To return to the search results, please enter \'back\'."
     reply = gets.strip
    if reply == "menu"
        call 
      elsif reply == "back"
      #figure out back method
      else 
        puts "I''m sorry, that is not a valid selection."
        next_choice
      end 
   end 
  
end 

DCPSCLIcontroller.new.call