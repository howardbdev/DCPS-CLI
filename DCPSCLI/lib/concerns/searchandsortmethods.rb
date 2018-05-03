module SearchAndSortMethods
  module ClassMethods 
 
  #This method takes in an array scraped from a website and instantiates an object for each item in the array
     def create_from_scraper(scraped_array)  
      scraped_array.each do |item|
        self.new(item)
      end
    end 
    
    #This method allows you to search the full array of names for a class
    def find_by_name(entry)
      names = []
      self.all.each do |item|
        if item.name.downcase.include? entry.downcase
        names << item 
       end 
     end 
    
      if names == [] 
        puts "Sorry, nothing found by that name."
      else 
        names.each do |item|
          puts "#{alphabetical.index(item) + 1}. #{item.name }"
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