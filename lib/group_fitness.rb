class GroupFitness

@@all = []

attr_accessor :name, :description

def initialize(name=nil,description=nil)
    @name = name
    @description = description
    @@all << self
end

def self.all
    @@all
end



end