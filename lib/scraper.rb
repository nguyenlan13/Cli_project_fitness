class Scraper

    def self.get_listings_page
        doc = Nokogiri::HTML(open("https://www.lafitness.com/Pages/AerobicClasses.aspx"))
    end

    def self.get_listings
        self.get_listings_page.css(".classdesc")
    end

    def self.scrape_listings
        listings = self.get_listings
        list = []
        list_ids = self.scrape_class_ids
        listings.each do |info|
            title_span = info.css(".lah3")
            title_id = title_span.attr('id').value
            description_name = title_id.sub! 'lblTitle', 'lblDescription'

            name = title_span.children[0].text

            description = info.css("#" + description_name)[0].text
            #scrape_url = info.css("div:nth-child(4) div:nth-child(4) a").attr("href")
            #scrape_url = info.css("a[href^='/Pages']").attr("href")

            #fitness_class_id = scrap_url.css()
            #puts scrape_url
            #binding.pry
            group_fitness = GroupFitness.new
            group_fitness.name = name
            group_fitness.description = description
            group_fitness.fitness_class_id = list_ids.key(name)
            #group_fitness.scrape_url = scrape_url
            
            list << group_fitness
            #binding.pry
        end
        return list
    end

    def self.get_class_ids
        self.get_listings_page.css("#ctl00_MainContent_DropDownListClasses")
    end

    def self.scrape_class_ids
        fitness_class_ids = self.get_class_ids
        id_list = {}
        
        fitness_class_ids.each do |info|

            info.children.each do |data, index|
                #binding.pry
                if data.children.text != "" && data.children.text != "Select a Class..."
                    #puts data.attributes['value']
                    #puts data.children.text
                    id_name = data.children.text
                    id_value = data.attributes['value'].value

                    #puts id_name
                    #binding.pry
                   # id_list = {'id_nam}
                    id_list[id_value] = id_name
                end
             end
        end
        return id_list
    end

    def self.get_locations_page(zip_code, group_fitness)
        base_url = "https://lafitness.com/Pages/LocateClassNearYou.aspx?camefrom=1&radius=10"
        location_url = base_url + "&postalcode=" + zip_code.to_s + "&id=" + group_fitness.fitness_class_id.to_s + "&name=" + group_fitness.name.to_s
        pg = Nokogiri::HTML(open(location_url))
        
    end

    def self.get_locations(zip_code, group_fitness)
        self.get_locations_page.css("div.panel.panel-default")
    end

    def self.scrape_locations(zip_code, group_fitness)
        locations = self.get_locations(zip_code, group_fitness)
        #binding.pry
        # list_of_locations = []
        # locations.each do |location|
        #     location_name = location.css("a.aLink").text
            #puts location_name
            #binding.pry
            #location_address = 

       #end
    #    return list_of_locations
    end
    
    
end
