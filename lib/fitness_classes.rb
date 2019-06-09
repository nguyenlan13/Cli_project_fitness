class GroupFitness

@@all = []

attr_accessor :name, :description, :location, :schedule

def initalize(name, description)
    @name = name
    @description = description

    @@all << self
end

def self.all
    @@all
end



end