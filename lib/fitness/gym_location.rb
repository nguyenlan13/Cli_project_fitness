class Fitness::GymLocation

    @@all = []

    attr_accessor :class_schedule, :group_fitness
    attr_writer :zip_code 
    attr_reader :location_name, :address, :distance

    def initialize(location_name, address, distance)
        @location_name = location_name
        @address = address
        @distance = distance
        #@class_schedule = class_schedule
        @group_fitness = group_fitness
        @@all << self
    end

    def self.all
        @@all
    end

    # def self.add_fitness_class(group_fitness_class)
    #     @group_fitness << group_fitness_class
    #     group_fitness_class.gym_locations = self
    # end


    # def self.fitness_classes
    #     @group_fitness
    # end


    # def add_fitness_class_by_name(class_name)
    #     group_fitness_class = GroupFitness.new(class_name)
    #     add_fitness_class(group_fitness_class)
    # end

end

  
