module SearchAndSortMethods
  module ClassMethods 
 
     def create_from_scraper(scraped_array)  
      scraped_array.each do |item|
        self.new(item)
      end
    end 
    
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
        puts item.name 
     end 
    end 
  end 
    
 end 
  
 module InstanceMethods
     
     def initialize(hash)
      hash.each do |key, value| 
        self.instance_variable_set("@#{key}".to_sym, value)
        end 
      self.class.all << self
    end 
 end
  
  
end 