class Fitness::GymLocation

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

    def self.find_or_create(name, description=nil, fitness_class_id)
        find = self.all.detect {|group_fitness_classes| group_fitness_classes if group_fitness_classes.name == name} 
        find == nil? self.new(name, description=nil, fitness_class_id): find
       end
   end

   def self.add_gym_location(gym_location)
       self.group_fitness_classes << GroupFitness.find_or_create(group_fitness_classes)
   end


    # def self.see_fitness_classes
    #     @group_fitness_classes
    # end

end

  
