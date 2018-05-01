class Principal
  attr_accessor :first_name, :last_name, :school, :email_address
  @@all = []
  
  def initialize()
    @first_name = first_name
    @last_name = last_name
    @school = school 
    @email_address = email_address
    @@all << self
  end 
  
  def make_principals_from_scraper(principal_hash)
  end
  
  
end 