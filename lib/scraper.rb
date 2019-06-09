class Scraper

    def get_page
        Nokogiri::HTML(open("https://www.lafitness.com/Pages/AerobicClasses.aspx"))
      end

    def get_name_listing
        self.get_page.css(".classMoreInfo")
    end

    def self.scrape_name
        self.get_name_listing.each do |info|
            group_fitness = GroupFitness.new
            group_fitness.name = info.css(".lah3").text
            group_fitness.description = info.css("#ctl00_MainContent_ClassContentGroup1_rptClasses_ctl01_lblClassFullDesc").text        end
        end
    end
end