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

    
end