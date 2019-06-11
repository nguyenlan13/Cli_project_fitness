class Scraper

    def self.get_page
        doc = Nokogiri::HTML(open("https://www.lafitness.com/Pages/AerobicClasses.aspx"))
        #pg = open("https://www.lafitness.com/Pages/AerobicClasses.aspx");
        #binding.pry
    end

    def self.get_listings
        self.get_page.css(".classdesc")
        
    end

    def self.scrape_listings
        listings = self.get_listings

        listings.each do |info|
            
            #name = info.css("span#ctl00_MainContent_ClassContentGroup1_rptClasses_ctl00_lblTitle.lah3")[0].text
            #description = info.css(("span")[1]).text
            #description = info.css("span#ctl00_MainContent_ClassContentGroup1_rptClasses_ctl01_lblClassFullDesc").text
            name = info.css(".lah3")[0].text
            description = info.css("span#ctl00_MainContent_ClassContentGroup1_rptClasses_ctl00_lblDescription")[0].text
            #binding.pry
            group_fitness = GroupFitness.new
            group_fitness.name = name
            group_fitness.description = description
            #GroupFitness.new_from_listings(info)
           
        end

        # listings.each do |info|
            #  group_fitness = GroupFitness.new
            #  name = info.css(".lah3").text
            #  description = info.css("#ctl00_MainContent_ClassContentGroup1_rptClasses_ctl01_lblClassFullDesc").text
            #  #binding.pry
            #  group_fitness.name = name
            #  group_fitness.description = description
         #end
        #binding.pry
    end
    #binding.pry
end
