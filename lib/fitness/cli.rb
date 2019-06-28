class Fitness::CLI

    def run
        self.welcome
        @scraped_list = Fitness::Scraper.scrape_class_listings
        loop do
            input = self.ask_to_see_list.upcase
            if input == "EXIT" || input == "N" || input =="NO"
                puts "See you next time!".red
                puts "\n\n"
                return
            elsif input == "Y" || input == "YES"
                self.group_fitness_list
                group_fitness = self.ask_which_class
                zip_code = self.ask_for_zip_code(group_fitness)
                self.show_classes_by_zip(zip_code, group_fitness)
                return 
            else
                puts "Sorry, please enter a valid response (Y/N)".red
            end
        end
    end


    def welcome
        puts "\n"
        puts "Hello, welcome to LA Fitness!".bold.yellow
        puts "\n"
    end


    def ask_to_see_list
        puts "\n"
        puts "Would you like to see the available group fitness classes? (Y/N)".magenta
        puts "\n\n"
        input = gets.strip
        puts "\n\n"
        return input
    end


    def ask_which_class
        puts "\n\n"
        puts "Please select class number to see description:".magenta
        puts "\n"
        input = gets.strip
        if input == "" || input == nil || input != input.to_i.to_s || input.to_i <= 0
            puts "\n\n"
            puts "Sorry, please enter a valid number".red
            puts "\n\n"
            return self.ask_which_class
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
        puts "Please enter your zip code to find nearby gyms:".magenta
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
       
         group_fitness.gym_locations = Fitness::Scraper.get_locations_post(zip_code, group_fitness) unless group_fitness.gym_locations.length != 0

        if  group_fitness.gym_locations.nil? || group_fitness.gym_locations.empty?
            puts "\n\n"
            puts "Sorry, #{group_fitness.name} was not found in your selected area, please choose another class:".red
            puts "\n\n"
            self.group_fitness_list
            group_fitness = self.ask_which_class
            zip_code = self.ask_for_zip_code(group_fitness)
            self.show_classes_by_zip(zip_code, group_fitness)
            return 
        else
            puts "\n\n"
            puts "Here are the schedule details for #{group_fitness.name} at the gyms in your area:".magenta
            puts "\n\n"
            self.gym_locations_list
            puts "Would you like to see a another class? (Y/N)".magenta
            puts "\n\n"
            loop do
                input = gets.strip.upcase
                if input == "EXIT" || input == "N" || input == "NO"
                    puts "\n\n"
                    puts "Enjoy your class!".yellow
                    puts "\n\n"
                    return
                elsif input == "Y" || input == "YES"
                    puts "\n\n"
                    loop do 
                        self.group_fitness_list
                        group_fitness = self.ask_which_class
                        self.show_classes_by_zip(zip_code, group_fitness)
                        return
                    end
                else
                    puts "Sorry, please enter a valid response (Y/N)".red
                end
            end
        end
    end


    def group_fitness_list      
        Fitness::GroupFitness.all.sort_by(&:name).each_with_index do |fitness_class, index|
            i = index + 1
            puts "#{i}".magenta + " - " + "#{fitness_class.name}".yellow
        end       
    end


    def gym_locations_list
        Fitness::GymLocation.all.each_with_index do |gym_location, index|
            i = index + 1
            puts "#{i}".bold.magenta + " - " + "#{gym_location.location_name}".bold.yellow
            puts "#{gym_location.address}".bold.yellow
            puts "\n"
            puts "#{gym_location.distance}".yellow
            puts "\n"
            puts "#{gym_location.class_schedule}"
            puts "\n\n"
        end
    end
  end 