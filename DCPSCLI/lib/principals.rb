require_relative "concerns/searchandsortmethods"
require "pry"

class Principal
  extend SearchAndSortMethods::ClassMethods
  include SearchAndSortMethods::InstanceMethods
  
  attr_accessor :first_name, :last_name, :school, :email_address, :full_name, :url, :name
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
  
  def self.find_principal_by_school
  end
  
  def self.view_all_principals_with_email_addresses
  end
  
  def view_principal_details
  end 
  
end
