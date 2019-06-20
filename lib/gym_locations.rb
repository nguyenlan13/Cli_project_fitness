class GymLocation

    @@all = []
    attr_accessor :location_name, :address, :distance, :class_schedule

    def initialize(location_name=nil, address=nil, distance=nil)
        @location_name = location_name
        @address = address
        @distance = distance
        #@class_schedule = class_schedule
        @@all << self
    end

    def self.all
        @@all
    end

end