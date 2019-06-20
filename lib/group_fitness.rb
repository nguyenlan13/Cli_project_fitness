class GroupFitness

@@all = []

attr_accessor :name, :description, :gym_location, :zip_code, :fitness_class_id

    def initialize(name=nil, description=nil, fitness_class_id=nil)
        @name = name
        @description = description
        @@all << self
    end

    def self.all
        @@all
    end
end