class Fitness::GroupFitness

    @@all = []

    attr_accessor :description, :gym_locations
    attr_reader :name, :fitness_class_id
  
    def initialize(name, description=nil, fitness_class_id)
        @name = name
        @description = description
        @fitness_class_id = fitness_class_id
        #a many to many relationship
        @gym_locations = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create(location_name, address, distance)
         find = self.all.detect {|gym_locations| gym_locations if gym_locations.location_name == location_name} 
         find == nil? self.new(location_name, address, distance)
        end
    end

    def self.add_gym_location(gym_locations)
        self.gym_locations << GymLocation.find_or_create(gym_locations)
    end


    # def self.see_gym_locations
    #     @gym_locations
    # end
    
end