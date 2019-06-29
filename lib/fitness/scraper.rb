class Fitness::Scraper

    LISTINGS_URL = "https://www.lafitness.com/Pages/AerobicClasses.aspx"
    URL_TO_POST = "https://www.lafitness.com/Pages/LocateClassNearYou.aspx/GetClassList"
    @@doc = Nokogiri::HTML(open(LISTINGS_URL))
   
    def self.get_listings
        @@doc.css(".classdesc")
    end


    def self.scrape_class_listings
        listings = self.get_listings
        list_of_classes = []
        id_list = self.scrape_class_ids
        
        listings.each do |info|
            title_span = info.css(".lah3")
            title_id = title_span.attr('id').value
            description_name = title_id.gsub('lblTitle', 'lblDescription')

            name = title_span.children[0].text.strip
            description = info.css("#" + description_name)[0].text
            fitness_class_id = id_list.key(name)
            group_fitness = Fitness::GroupFitness.new(name, description, fitness_class_id)
         
            list_of_classes << group_fitness

            group_fitness.group_fitness_classes = Fitness::GymLocation.find_or_create_by_name(list_of_classes)
        end
        return list_of_classes
    end


    def self.get_class_ids
        @@doc.css("#ctl00_MainContent_DropDownListClasses")
    end


    def self.scrape_class_ids
        fitness_class_ids = self.get_class_ids
        id_list = {}
        fitness_class_ids.children.each do |info|
            if info.children.text != "" && info.children.text != "Select a Class..."
                id_name = info.children.text
                id_value = info.attributes['value'].value
                id_list[id_value] = id_name
            end
        end
        return id_list
    end

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
        if locations == nil
            return locations
        else
            list_of_locations = []
            locations.each do |location, location_details|
                location_name = location['ClubName']
                location_address1 = location['AddressLine1']
                location_address2 = location['AddressLine2']
                address = "#{location_address1} #{location_address2}"
                distance = location['Distance']
                schedules = location['ClassSchedule']
            
                gym_location = Fitness::GymLocation.new(location_name, address, distance)
               
                class_schedule = ""
                schedules.each do |schedule, schedule_details|
                    day = schedule['Day'].to_s.gsub("&nbsp;","       ")
                    time = schedule['Time']
                    instructor = schedule['Instructor'].strip
                    class_schedule += "#{day}  #{time} - #{instructor}\n"
                end
                gym_location.class_schedule = class_schedule
                list_of_locations << gym_location
            end
            return list_of_locations
        end
    end
end

