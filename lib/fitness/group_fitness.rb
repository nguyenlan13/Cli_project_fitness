#require_relative '../concerns/findable'
class Fitness::GroupFitness
    #extend Concerns::Findable
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

    def self.find_or_create(name, description=nil, fitness_class_id)
        find = self.all.detect {|group_fitness_classes| group_fitness_classes if group_fitness_classes.name == name && group_fitness_classes.fitness_class_id == fitness_class_id} 
        find == nil? do Fitness::GroupFitness.new(name, description=nil, fitness_class_id)
        end
   end

    def self.add_gym_location(gym_location)
        self.gym_locations << Fitness::GymLocation.find_or_create(gym_location)
    end


    # def self.see_gym_locations
    #     self.gym_locations
    # end
    
end