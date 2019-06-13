class CLI

    def run
        self.welcome
        @scraped_list = Scraper.scrape_listings
        self.menu
    end

    def welcome
        puts "Hello, welcome to LA Fitness!"
        puts "Please select class number to see description:"
        #Scraper.scrape_listings
        #binding.pry
        puts self.group_fitness_list

        #bin/runbinding.pry
        input = gets.strip.to_i
            # if input
            # end
            #print group_fitness_list(input)
    end

    def menu
        input = gets.strip.to_i






    
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
        GroupFitness.all.sort_by(&:name).each_with_index do |index, fitness_klass|
            #binding.pry
             puts "#{index + 1} - #{fitness_klass.name}"
             #binding.pry
             #counter +=1
        end       
    end
end
