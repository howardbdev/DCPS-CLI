require_relative "concerns/searchandsortmethods"
require "pry"

class Principal
  extend SearchAndSortMethods::ClassMethods
  include SearchAndSortMethods::InstanceMethods
  
  attr_accessor :first_name, :last_name, :school, :email_address, :name, :url
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
    end
  
  #This method puts all principal names with email addresses
  def self.view_all_principals_with_email_addresses
    @@all.each do |principal|
      puts "#{alphabetical.index(principal) + 1}. #{principal.name}: #{principal.email_address}"
    end 
  end
  
  #This method allows you to view details for an individual principal
  def view_principal_details
      puts "Name: #{@name}"
      puts "School: #{@school.name}"
      puts "Email Address: #{@email}"
      puts "Address: #{@school.address}"
      puts "School Profile: http://profiles.dcps.dc.gov#{@url}"
  end 
  
end
