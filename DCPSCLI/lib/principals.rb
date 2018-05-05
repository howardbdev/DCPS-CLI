require_relative "../lib/concerns/searchandsortmethods"

class Principal
  extend SearchAndSortMethods::ClassMethods
  include SearchAndSortMethods::InstanceMethods
  
  attr_accessor :first_name, :last_name, :school, :email, :name, :url, :controller_session
  @@all = []
  
    def self.all
      @@all
    end
    
  #This method puts the names of all principals alphabetically by last name
  def self.view_principals_alphabetically
      alphabetical = self.all.sort_by {|item| item.last_name}
      alphabetical.each do |item|
        puts "#{alphabetical.index(item) + 1}. #{item.name}"
      end
      alphabetical
    end
  
  #This method puts all principal names with email addresses
  def self.view_all_principals_with_email_addresses
    @@all.each do |principal|
      puts "#{all.index(principal) + 1}. #{principal.name}: #{principal.email}"
    end
    @@all
  end
  
  #This method allows you to view details for an individual principal
  def view_details
      puts "Name: #{@name}"
      puts "School: #{@school.name}"
      puts "Grades: #{@school.grades}"
      puts "Email Address: #{@email}"
      puts "Address: #{@school.address}"
      puts "School Profile: http://profiles.dcps.dc.gov#{@url}"
  end 
  
end
