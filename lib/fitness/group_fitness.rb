class Fitness::GroupFitness

    @@all = []

    attr_accessor :description
    attr_reader :name, :fitness_class_id
  
    def initialize(name, description=nil, fitness_class_id)
        @name = name
        @description = description
        @fitness_class_id = fitness_class_id
        @@all << self
    end

    def self.all
        @@all
    end
end