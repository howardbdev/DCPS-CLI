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
  
end 