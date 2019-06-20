class GroupFitness

@@all = []

attr_accessor :name, :description, :gym_location, :zip_code, :fitness_class_id #:class_schedule

    def initialize(name=nil, description=nil, fitness_class_id=nil)
        @name = name
        @description = description
        #@fitness_class_id = fitness_class_id
        @@all << self
    end

    def self.all
        @@all
    end

    # def find_by_name(name)
    #     all.select {|fitness_class| fitness_class.name == name}[0]
    # end



end