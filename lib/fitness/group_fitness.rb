class Fitness::GroupFitness

    @@all = []

    attr_accessor :description, :gym_locations
    attr_reader :name, :fitness_class_id
  
    def initialize(name, description=nil, fitness_class_id)
        @name = name
        @description = description
        @fitness_class_id = fitness_class_id
        @gym_locations = []
        @@all << self
    end

    def self.all
        @@all
    end

    # def self.find_or_create_by_name(name)
    #     find_by_name(name) || create(name)
    #     @gym_locations << self
    # end

    # def self.add_gym_location(gym_location)
    #     gym_location = GymLocation.new(gym_location, self)
    #     @gym_locations << gym_location
    #     gym_location
    # end


    # def self.see_gym_locations
    #     @gym_locations
    # end


    # def add_gym_location_by_name(location_name)
    #     gym_location = GymLocation.new(location_name)
    #     add_gym_location(gym_location)
    # end
    
end