class Fitness::GymLocation

    @@all = []

    attr_accessor  :class_schedule
    attr_reader :location_name, :address, :distance

    def initialize(location_name, address, distance)
        @location_name = location_name
        @address = address
        @distance = distance
        @@all << self
    end

    def self.all
        @@all
    end
end