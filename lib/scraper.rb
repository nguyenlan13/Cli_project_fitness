class Scraper

    LISTINGS_URL = "https://www.lafitness.com/Pages/AerobicClasses.aspx"
    #LOCATIONS_BASE_URL = "https://lafitness.com/Pages/LocateClassNearYou.aspx?camefrom=1&radius=10"
    URL_TO_POST = "https://www.lafitness.com/Pages/LocateClassNearYou.aspx/GetClassList"


    def self.get_listings_page
        doc = Nokogiri::HTML(open(LISTINGS_URL))
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

            name = title_span.children[0].text.strip
            description = info.css("#" + description_name)[0].text
        
            #binding.pry
            group_fitness = GroupFitness.new#(name,description)
            group_fitness.name = name
            group_fitness.description = description
            group_fitness.fitness_class_id = list_ids.key(name)
            
            list << group_fitness
            #binding.pry
        end
        return list
    end

    def self.get_class_ids
        self.get_listings_page.css("#ctl00_MainContent_DropDownListClasses")
        #can this id be scraped within get listings method?
    end

    def self.scrape_class_ids
        #check if ids can be scraped within scrape_listings method instead? - avoid opening same page to be scraped again
        
        fitness_class_ids = self.get_class_ids
        id_list = {}
        
        fitness_class_ids.each do |info|

            info.children.each do |data, index|
                if data.children.text != "" && data.children.text != "Select a Class..."
                    #puts data.attributes['value']
                    #puts data.children.text
                    id_name = data.children.text
                    id_value = data.attributes['value'].value
                    #puts id_name
                    #binding.pry
                    id_list[id_value] = id_name
                end
            end
        end
        return id_list
    end

    # def self.get_locations_page(zip_code, group_fitness)
    #     #base_url = "https://lafitness.com/Pages/LocateClassNearYou.aspx?camefrom=1&radius=10"
    #     location_url = LOCATIONS_BASE_URL + "&postalcode=" + zip_code.to_s + "&id=" + group_fitness.fitness_class_id.to_s + "&name=" + group_fitness.name.gsub(' ', '+').to_s
    #     pg = Nokogiri::HTML(open(location_url))
    #     #binding.pry
    # end

    def self.get_locations_post(zip_code, group_fitness)
        response = HTTParty.post(
          URL_TO_POST,
          :body => JSON.generate({ClassId: group_fitness.fitness_class_id, ZipCode: zip_code, MileRange: 10}),
          :headers => {
              "Content-Type" => "application/json; charset=UTF-8",
              "Accept" => "*/*"
          }
        )
     
        locations = response['d'][0]['ViewByClub']

        list_of_locations = []
        locations.each do |location, details|
            location_name = location['ClubName']
            location_address1 = location['AddressLine1']
            location_address2 = location['AddressLine2']
            address = "#{location_address1} #{location_address2}"
            distance = location['Distance']
            schedules = location['ClassSchedule']
         
            gym_location = GymLocations.new
            gym_location.location_name = location_name
            gym_location.address = address 
            gym_location.distance = distance
        
            class_schedule = ""
            schedules.each do |schedule, details|
                day = schedule['Day']
                time = schedule['Time']
                instructor = schedule['Instructor'].strip
                class_schedule += "#{day} - #{time} - #{instructor}\n"
            end
            gym_location.class_schedule = class_schedule;
        
            list_of_locations << gym_location
        end
        return list_of_locations
    end
end

