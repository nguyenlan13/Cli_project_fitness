class Gyms

    @@all = []
    attr_accessor :location_name, :address, :schedule

    def initialize(location_name=nil, address=nil, schedule=nil)
        @location_name = location_name
        @address = address
        @schedule = schedule
        @@all << self
    end

    def self.all
        @@all
    end

end