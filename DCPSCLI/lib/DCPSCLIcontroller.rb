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
  
  #This method displays the menu and allows the user to pick an option to execute
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
    elsif choice == "exit"
      puts "Thank you for your time!"
      exit 
    else
      puts "I\'m sorry, that is not a valid selection."
      call
    end 
   end 
 
   #This method runs when a selection has been made to execute the user's choice
   def upon_selection(choice)
       choice
       @most_recent_array = choice
       more_information
    end 
       
  #This method allows the user to get more information about a school or principal or return to the main menu
  def more_information
     puts "\n"
     puts "For more information on a #{@most_recent_array[0].class.name.downcase}, please enter an item number or enter \'menu\' to return to the menu"
     entry = gets.strip
      if entry.downcase == "menu"
        call
      elsif entry.match(/\d+/)
        details(entry.to_i)

      else
        puts "I'm sorry, that is not a valid entry."
        more_information 
     end 
   end 
   
   #This method shows the user details about a school or principal
   def details(entry)
     @most_recent_array[entry - 1].view_details
     next_choice
    end
    
   #This method runs after a user has viewed details allowing them either to return to their search results or the main menu
    def next_choice
    puts "To return to the main menu, please enter \'menu\'.  To return to the search results, please enter \'back\'."
     reply = gets.strip
    if reply == "menu"
        call 
      elsif reply == "back"
      @most_recent_array.each do |item|
          puts "#{@most_recent_array.index(item) + 1}. #{item.name}"
        end 
          more_information
      else 
        puts "I\'m sorry, that is not a valid selection."
        next_choice
      end 
   end 
  
end 

DCPSCLIcontroller.new.call