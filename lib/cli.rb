class CLI

    # def run
    #     Scraper.get_locations_post(" "," ")

    # end

    def run
        self.welcome
        @scraped_list = Scraper.scrape_listings
       
        loop do
            input = self.ask_to_see_list
            if input == "exit" || input == "n"


                #downcase inputs?
                #puts "exiting..."
                return
            elsif input == "y" || input == "yes"
                self.group_fitness_list
                group_fitness = self.ask_which_class
                #Scraper.scrape_class_ids
                self.ask_for_zip_code(group_fitness)
               
                return
            else
                #puts "printing list"
                #puts input
                puts "wtf?".cyan
                #return
            end
        end
        
    end




    def welcome
        puts "\n"
        puts "Hello, welcome to LA Fitness!".cyan
        puts "\n"
    end



    def ask_to_see_list
        puts "\n"
        puts "Would you like to see the available group fitness classes? (y/n)".cyan
        puts "\n\n"
        input = gets.strip
        puts "\n\n"
        return input
    end
    

    def ask_which_class
        puts "\n\n"
        puts "Please select class number to see description:".cyan
        puts "\n"
        #input = gets.strip.to_i
        input = gets.strip

        if input == "" || input == nil
            puts "\n\n"
            puts "Sorry, please enter a number".cyan
            puts "\n\n"
            self.ask_which_class
            return
        end
        index = input.to_i - 1

        group_fitness = @scraped_list[index]
        puts "\n\n"
        puts group_fitness.name
        puts "\n"
        puts group_fitness.description
        return group_fitness
    end




    def ask_for_zip_code(group_fitness)
        puts "\n\n"
        puts "Please enter your zip code to find nearby gyms:".cyan
        puts "\n\n"
        input = gets.strip
                
        if input == "" || input == nil
            puts "\n\n"
            puts "Sorry, please enter a a valid zip code".cyan
            puts "\n\n"
            self.ask_for_zip_code(group_fitness)
            return
        end
        zip_code = input.to_s

        #scrape_url = group_fitness.scrape_url
        #fitness_class_id = group_fitness.fitness_class_id
        #name = group_fitness.name
        #@scraped_location = Scraper.scrape_locations(zip_code, group_fitness)

        puts "\n\n"
        puts "Here are the schedule details for #{group_fitness.name} at the gyms in your area:".cyan
        puts "\n\n"
        @location_post = Scraper.get_locations_post(zip_code, group_fitness)
        #self.gym_locations_list
    end
#puts ""

    def group_fitness_list
    #     # user_input = gets
    #     # group_fitness_name = GroupFitness.find_by_name(user_input)
    #     # return if group_fitness_name.nil?
        #counter = 1
        GroupFitness.all.sort_by(&:name).each_with_index do |fitness_class, index|
            #binding.pry
            i = index + 1
             puts "#{i} - #{fitness_class.name}"
            #  binding.pry
             #counter +=1
        end       
    end



    def gym_locations_list
        Gyms.all.each_with_index do |gym, index|
            i = index + 1
            puts "#{i} - #{gym.location_name}"
            puts "#{gym.address}"
            #puts "#{gym.distance}"
            #puts "#{gym.schedule}"
        end
    end

    

end
