#require_relative '../concerns/findable'
class Fitness::GymLocation
    #extend Concerns::Findable
    @@all = []

    attr_accessor :class_schedule, :group_fitness_classes
    attr_writer :zip_code 
    attr_reader :location_name, :address, :distance

    def initialize(location_name, address, distance)
        @location_name = location_name
        @address = address
        @distance = distance
        #@class_schedule = class_schedule
        #a many to many relationship
        @group_fitness_classes = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create(location_name, address, distance)
        find = self.all.detect {|gym_locations| gym_locations if gym_locations.location_name == location_name} 
        find == nil? do Fitness::GymLocation.new(location_name, address, distance)
        end
    end

    def self.add_group_fitness_classes(group_fitness)
        self.group_fitness_classes << Fitness::GroupFitness.find_or_create(group_fitness)
    end


    # def self.see_fitness_classes
    #     @group_fitness_classes
    # end

end

  
