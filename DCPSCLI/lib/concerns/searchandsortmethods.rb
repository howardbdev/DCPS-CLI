module SearchAndSortMethods
  module ClassMethods 
 
  #This method takes in an array scraped from a website and instantiates an object for each item in the array
     def create_from_scraper(scraped_array)  
      scraped_array.each do |item|
        self.new(item)
      end
    end 
    
    #This method allows you to enter a search value and returns an array of all the names from the class that include that search value
    def enter_search_value
      puts "Please enter a search value"
      entry = gets.strip.downcase
      entry
    end 
      
    def find_by_name(entry)
      names = []
      self.all.each do |item|
        if item.name.downcase.include? entry
        names << item 
       end
     end
       names
     end 
       

    def search_not_found
      puts "Please enter \'menu\' to return to the menu or enter another search term"
      new_entry = gets.strip.downcase
         if new_entry == "menu"
           DCPSCLIcontroller.new.call
         else 
           self.return_name_search_results(find_by_name(new_entry))
         end 
      end 

       
    def return_name_search_results(names)
      if names == []
         puts "Sorry, nothing found by that name."
         self.search_not_found
      else
        names.each do |item|
          puts "#{names.index(item) + 1}. #{item.name }"
       end 
      end 
    end
    
  end 
  
 module InstanceMethods
     
     #This initialize method accepts a hash and creates a version of the object with an attribute for each key in the hash
     def initialize(hash)
      hash.each do |key, value| 
        self.instance_variable_set("@#{key}".to_sym, value)
        end 
       self.class.all << self
     end
     
   end 

end 