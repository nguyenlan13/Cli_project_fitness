class CLI

    def run
        self.welcome
        @scraped_list = Scraper.scrape_listings
        loop do
            input = self.ask_to_see_list.downcase
            if input == "exit" || input == "n"
                puts "See you next time!".red
                puts "\n\n"
                return
            elsif input == "y" || input == "yes"
                self.group_fitness_list
                group_fitness = self.ask_which_class
                zip_code = self.ask_for_zip_code(group_fitness)
                self.show_classes_by_zip(zip_code, group_fitness)
                return
            else
                puts "Sorry, please enter a valid response (y/n)".red
            end
        end
    end


    def welcome
        puts "\n"
        puts "Hello, welcome to LA Fitness!".bold.green
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
        input = gets.strip
        # if input != '0' && input.to_i.to_s != input.strip
        if input == "" || input == nil || input != input.to_i.to_s 
            puts "\n\n"
            puts "Sorry, please enter a valid number".red
            puts "\n\n"
            self.ask_which_class
            return
        end
        
        index = input.to_i - 1
    
        group_fitness = @scraped_list[index]
        if group_fitness == nil
            puts "\n\n"
            puts "Please select an available class from the list".red
            puts "\n"
            return self.ask_which_class
        end
            puts "\n\n"
            puts group_fitness.name
            puts "\n"
            puts group_fitness.description
            puts "\n"
        return group_fitness
    end


    def ask_for_zip_code(group_fitness)
        puts "\n\n"
        puts "Please enter your zip code to find nearby gyms:".cyan
        puts "\n\n"
        input = gets.strip
                
        if input == "" || input == nil || input != input.to_i.to_s
            puts "\n\n"
            puts "Sorry, please enter a a valid zip code".red
            puts "\n\n"
            return self.ask_for_zip_code(group_fitness)
        end
        zip_code = input.to_s
        return zip_code
    end


    def show_classes_by_zip(zip_code, group_fitness)
        @get_locations = Scraper.get_locations_post(zip_code, group_fitness)
        if  @get_locations.nil? || @get_locations.empty?
            puts "\n\n"
            puts "Sorry, #{group_fitness.name} was not found in your selected area, please choose another class:".red
            puts "\n\n"
            self.group_fitness_list
            group_fitness = self.ask_which_class
            zip_code = self.ask_for_zip_code(group_fitness)
            self.show_classes_by_zip(zip_code, group_fitness)
        else
            puts "\n\n"
            puts "Here are the schedule details for #{group_fitness.name} at the gyms in your area:".cyan
            puts "\n\n"
            self.gym_locations_list
            return       
        end
    end


    def group_fitness_list      
        GroupFitness.all.sort_by(&:name).each_with_index do |fitness_class, index|
            i = index + 1
            puts "#{i} - #{fitness_class.name}"
        end       
    end


    def gym_locations_list
        GymLocation.all.each_with_index do |gym_location, index|
            i = index + 1
            puts "#{i} - #{gym_location.location_name}"
            puts "#{gym_location.address}"
            puts "#{gym_location.distance}"
            puts "#{gym_location.class_schedule}"
            puts "\n\n"
        end
    end
end
