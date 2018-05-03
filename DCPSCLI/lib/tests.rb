require_relative "scraper"
require_relative "principals"
require_relative "concerns/searchandsortmethods"
require_relative "schools"
require "pry"


School.create_from_scraper(Scraper.school_test)
Principal.create_from_scraper(Scraper.principal_test)
School.match_principals
Principal.all[2].view_principal_details