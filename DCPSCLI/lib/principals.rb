class Principal
  attr_accessor :first_name, :last_name, :school, :email_address
  
  def initialize(first_name, last_name, school, email_address)
    @first_name = first_name
    @last_name = last_name
    @school = school 
    @email_address = email_address
  end 
  
  def make_principals_from_scraper(principal_hash)
  end
  
  
end 