class Gyms

    @@all = []
    attr_accessor :location_name, :address, :distance

    def initialize(location_name=nil, address=nil, distance=nil)
        @location_name = location_name
        @address = address
        @distance = distance
        #@schedule = schedule
        @@all << self
    end

    def self.all
        @@all
    end

end