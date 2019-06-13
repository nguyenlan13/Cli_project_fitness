class Scraper

    def self.get_listings_page
        doc = Nokogiri::HTML(open("https://www.lafitness.com/Pages/AerobicClasses.aspx"))
        #pg = open("https://www.lafitness.com/Pages/AerobicClasses.aspx");
        #binding.pry
    end

    def self.get_listings
        self.get_listings_page.css(".classdesc")
        
    end

    def self.scrape_listings
        listings = self.get_listings
        list = []
        listings.each do |info|
            title_span = info.css(".lah3")
            title_id = title_span.attr('id').value
            description_name = title_id.sub! 'lblTitle', 'lblDescription'

            name = title_span.children[0].text
            description = info.css("#" + description_name)[0].text
            #scrape_url = info.css("div:nth-child(4) div:nth-child(4) a").attr("href")
            scrape_url = info.css("a[href^='/Pages']").attr("href")

            #puts scrape_url
            #binding.pry
            group_fitness = GroupFitness.new
            group_fitness.name = name
            group_fitness.description = description
            group_fitness.scrape_url = scrape_url
            

            list << group_fitness
            
            #puts group_fitness.description
            # GroupFitness.new_from_listings(group_fitness)
            #binding.pry
        end
        return list
    end
    


    def self.scrape_locations(scrape_url, zip_code)
        url = "https://www.lafitness.com" + scrape_url + "&postalcode=" + zip_code.to_s
        pg = Nokogiri::HTML(open(url))

    end

    # def self.get_locations
    #     self.get_locations_page.css("")
        
    # end

    # def self.scrape_locations(zip_code, class_id)
    #         locations = self.get_locations

    # end
    
end
