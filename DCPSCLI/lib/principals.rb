require_relative "concerns/searchandsortmethods"
require "pry"

class Principal
  extend SearchAndSortMethods::ClassMethods
  include SearchAndSortMethods::InstanceMethods
  
  attr_accessor :first_name, :last_name, :school, :email_address, :full_name, :url
  @@all = []
  
    def self.all
      @@all
    end
  
  def initialize(hash)
    super
    @name = @full_name
  end 
  
  def self.view_principals_alphabetically
      alphabetical = self.all.sort_by {|item| item.last_name}
      alphabetical.each do |item|
        puts item.full_name
      end 
    end
  
  def self.find_principal_by_school(entry)
      names = []
      @@all.each do |principal|
    if principal.school.name.include? entry.downcase
        names << principal
    end 
    end 
    
    if names == [] 
      puts "Sorry, there are no schools by that name."
    else 
      names.each do |principal|
        puts "Principal: #{principal.full_name}, School: #{principal.school.name}"
     end 
    end 
  end
  
  def self.view_all_principals_with_email_addresses
    @@all.each do |principal|
      puts "#{principal.full_name}: #{principal.email_address}"
    end 
  end
  
  def view_principal_details
      puts "Name: #{@name}"
      puts "School: #{@school.name}"
      puts "Email Address: #{@email}"
      puts "School Profile: http://profiles.dcps.dc.gov#{@url}"
  end 
  
end
