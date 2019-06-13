class CLI

    attr_reader :scraped_list

    def run
        self.welcome
        @scraped_list = Scraper.scrape_listings
        
        loop do
            input = self.ask_to_see_list
            if input == "exit" || input == "n"
                #puts "exiting..."
                return
            elsif input == "y" || input == "yes"
                self.group_fitness_list
                group_fitness = self.ask_which_class
                self.ask_for_zip_code(group_fitness)

                #return
            else
                #puts "printing list"
                #puts input
                puts "wat?"
                #return
            end
        end
        




    end



    def welcome
        puts "Hello, welcome to LA Fitness!"
    end

    def ask_to_see_list
        puts "Would you like to see the available group fitness classes? (y/n)"
        input = gets.strip
        return input
    end
    
    def ask_which_class
        puts "Please select class number to see description:"
        input = gets.strip.to_i
        
        index = input - 1

        group_fitness = @scraped_list[index]
        puts group_fitness.name
        puts group_fitness.description
        
        return group_fitness
    end

    def ask_for_zip_code(group_fitness)
        puts "Please enter your zip code to find nearby gyms:"
        zip_code = gets.strip.to_i
        
        scrape_url = group_fitness.scrape_url

        @scraped_location = Scraper.scrape_locations(scrape_url, zip_code)
    end





    # def gets
    #     $stdin.gets
    # end

    def group_fitness_list
    #     #puts ""
    #     # user_input = gets
    #     # group_fitness_name = GroupFitness.find_by_name(user_input)
    #     # return if group_fitness_name.nil?
        #counter = 1
        GroupFitness.all.sort_by(&:name).each_with_index do |fitness_klass, index|
            #binding.pry
            i = index + 1
             puts "#{i} - #{fitness_klass.name}"
             #binding.pry
             #counter +=1
        end       
    end
end
