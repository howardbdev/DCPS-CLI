module SearchAndSortMethods
  module ClassMethods 
    
    def create_from_scraper(scraped_array)  
      scraped_array.each do |item|
        self.new(item)
      end
    end 
    
  end 
  
  module InstanceMethods
  
  end
  
  
end 