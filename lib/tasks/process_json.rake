namespace :procurement do
  desc "Processes Json data retrived from a full web scrape and inputs results into a database"
  task:full_scrape => :environment do
    require "scraper_file"
    ScraperFile.processFullScrape
  end
  
  desc "Processes Json data retrived from a partial web scrape and inputs results into a database"
  task:incremental_scrape => :environment do
    require "scraper_file"
    ScraperFile.processIncrementalScrape
  end
end