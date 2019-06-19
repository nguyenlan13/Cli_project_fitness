class GroupFitness

@@all = []

attr_accessor :name, :description, :gym_location, :schedule, :zip_code, :fitness_class_id


    # def self.new_from_listings(group_fitness)
    #     self.new(group_fitness.name, group_fitness.description)
    # end
    def initialize(name=nil, description=nil)
        @name = name
        @description = description
        #@fitness_class_id = fitness_class_id
        @@all << self
    end

    # def to_s
    #     @name
    # end

    def self.all
        @@all
    end

    # def find_by_name(name)
    #     all.select {|fitness_class| fitness_class.name == name}[0]
    # end



end