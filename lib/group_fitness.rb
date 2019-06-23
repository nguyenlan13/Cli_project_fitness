class GroupFitness

    @@all = []

    attr_accessor :description, :gym_location, :fitness_class_id
    attr_writer :zip_code
    attr_reader :name
  
    def initialize(name, description=nil, fitness_class_id=nil)
        @name = name
        @description = description
        @fitness_class_id = fitness_class_id
        @@all << self
    end

    def self.all
        @@all
    end
end