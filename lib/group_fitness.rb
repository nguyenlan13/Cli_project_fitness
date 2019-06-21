class GroupFitness

    @@all = []

    attr_accessor :name, :description, :gym_location, :fitness_class_id
    attr_writer :zip_code

    def initialize(name=nil, description=nil, fitness_class_id=nil)
        @name = name
        @description = description
        @fitness_class_id = fitness_class_id
        @@all << self
    end

    def self.all
        @@all
    end
end