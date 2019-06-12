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
        list = []
        listings.each do |info|
            title_span = info.css(".lah3")
            title_id = title_span.attr('id').value
            description_name = title_id.sub! 'lblTitle', 'lblDescription'

            name = title_span.children[0].text
            description = info.css("#" + description_name)[0].text
            #binding.pry
            group_fitness = GroupFitness.new
            group_fitness.name = name
            group_fitness.description = description
            
            list << group_fitness

            GroupFitness.new_from_listings(group_fitness)
            binding.pry
        end
            puts list
    end
    
end
