class GymClass

    @@all = []
    attr_accessor :address, :schedule

    def initialize(address=nil, schedule=nil)
        @address = address
        @schedule = schedule
        @@all << self
    end

    def self.all
        @@all
    end
end