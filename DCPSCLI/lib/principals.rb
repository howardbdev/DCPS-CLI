class Principal
  attr_accessor :first_name, :last_name, :school, :email_address, :full_name, :url
  @@all = []
  
   def initialize(principal_hash)
       principal_hash.each do |key, value| 
         self.instance_variable_set("@#{key}".to_sym, value)
      end 
    @@all << self
   end 
  
   def self.create_from_scraper(principals_array)  
     principals_array.each do |principal|
        Principal.new(principal)
     end
   end 
  
  def self.all
    @@all
  end
  
  def self.sort_by_first_name
    
  end 
  
  def self.find_principal_by_school
  end
  
  def self.view_all_principals_with_email_addresses
  end
  
  def view_principal_details
  end 
  
end
