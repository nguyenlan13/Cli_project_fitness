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
            #scrape_url = info.css("div:nth-child(4) div:nth-child(4) a").attr("href")
            #scrape_url = info.css("a[href^='/Pages']").attr("href")

          
            #puts scrape_url
            #binding.pry
            group_fitness = GroupFitness.new#(name, description)
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
        #can this id be scraped within get listings method?
    end

    def self.scrape_class_ids

        #check if ids can be scraped within scrape_listings method instead? - avoid opening same page to be scraped again
        
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
                    id_list[id_value] = id_name
                end
             end
        end
        return id_list
    end

    def self.get_locations_page(zip_code, group_fitness)
        #base_url = "https://lafitness.com/Pages/LocateClassNearYou.aspx?camefrom=1&radius=10"
        location_url = LOCATIONS_BASE_URL + "&postalcode=" + zip_code.to_s + "&id=" + group_fitness.fitness_class_id.to_s + "&name=" + group_fitness.name.gsub(' ', '+').to_s
        pg = Nokogiri::HTML(open(location_url))
        #binding.pry
    end

    def self.get_locations_post(zip_code, group_fitness)
        #url_to_post = 'https://www.lafitness.com/Pages/LocateClassNearYou.aspx/GetClassList'
        response = HTTParty.post(
            URL_TO_POST,
            :body => JSON.generate({ClassId: group_fitness.fitness_class_id, ZipCode: zip_code, MileRange: 10}),
            #"{ClassId: #{group_fitness.fitness_class_id}, ZipCode: '#{zip_code}', MileRange: 10}",#{"ClassId" => '26', "ZipCode" => "'92614'", "MileRange" => '10' }.to_json,
            :headers => {
                 "Content-Type" => "application/json; charset=UTF-8",
                 "Accept" => "*/*"
            }
        )
        #binding.pry

        locations = response['d'][0]['ViewByClub']

        #parsed_locations = JSON.parse(response)
 
        list_of_locations = []
        locations.each do |location, details|
            location_name = location['ClubName']
            location_address1 = location['AddressLine1']
            location_address2 = location['AddressLine2']
            address = location_address1 + " " + location_address2
            distance = location['Distance']
            day = location['ClassSchedule']['Day']
            time = location['ClassSchedule']['Time']
            instructor = location['ClassSchedule']['instructor'].strip
            #schedule = 

        binding.pry
            gym_location = GymLocations.new
                  gym_location.location_name = location_name
                  list_of_locations << gym_location
        end
        return list_of_locations
    end
    
    # def self.get_locations(zip_code, group_fitness)
    #      #locations = JSON.parse(response)
    #     #  locations = self.get_locations_post(zip_code, group_fitness)
    #     #  list_of_locations = []
    #     #  locations.each do |location|
    #      location_name = location['ClubName']
    #      #puts location_name

    #      gym_location = GymLocations.new
    #      gym_location.location_name = location_name
    #      list_of_locations << gym_location
    #      end
    #      return list_of_locations
 


# => {"d"=>
#   [{"__type"=>"ClassList",
#     "ViewByClub"=>
#      [{"Time"=>nil,
#        "ClubId"=>"15",
#        "ClubName"=>"FOUNTAIN VALLEY",
#        "AddressLine1"=>"10115 TALBERT AVENUE",
#        "AddressLine2"=>"FOUNTAIN VALLEY CA 92708",
#        "Distance"=>"7 miles",
#        "Instructor"=>nil,
#        "MapUrl"=>nil,
#        "ClassSchedule"=>[{"Day"=>"Thursday", "Time"=>"8:30 AM", "Instructor"=>"Catherine      "}]}],
#     "ViewByDay"=> 
#      [{"Day"=>"Thursday",



    #      end
    #      puts location_name
    # end

    # def self.get_locations(zip_code, group_fitness)
    #     get_locations_page(zip_code, group_fitness)#.css("#tabViewByClub .panel-group").children
    #     #binding.pry
    # end

    # def self.scrape_locations(zip_code, group_fitness)
    #     locations = self.get_locations(zip_code, group_fitness)
    #     #binding.pry
    #     list_of_locations = []
    #     locations.each do |location|
    #         #location_name = location.css("a.aLink b").text
    #         #location_address = location.css()
    #         location_distance = location.css("span.iDistance").text
    #         puts location_distance
    #         #binding.pry
    #         #location_schedule = 

    #    end
    # #    return list_of_locations
    # end
    
    
end
