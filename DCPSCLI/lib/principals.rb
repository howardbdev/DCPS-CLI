require "pry"

class Principal
  attr_accessor :first_name, :last_name, :school, :email_address, :name, :url
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
  
  def self.sort_by_last_name
    alphabetical_principals = @@all.sort_by {|principal| principal.last_name}
      alphabetical_principals.each do |principal|
        puts "#{principal.full_name}, #{principal.school.name}"
       end
  end 
  
  def self.find_principal_by_school
  end
  
  def self.view_all_principals_with_email_addresses
  end
  
  def view_principal_details
  end 
  
end
