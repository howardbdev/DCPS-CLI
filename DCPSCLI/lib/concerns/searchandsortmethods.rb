module SearchAndSortMethods
  module ClassMethods 
    
    def create_from_scraper(scraped_array)  
      scraped_array.each do |item|
        self.new(item)
      end
    end 
    
    def self.view_alphabetically
      alphabetical = @@all.sort_by {|item| item.name}
      alphabetical.each do |item|
        puts item.name
      end 
    end 
    
    def self.find_by_name(entry)
      names = []
      @@all.each do |item|
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
  
  end
  
  
end 