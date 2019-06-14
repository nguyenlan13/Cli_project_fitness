class GroupFitness

@@all = []

attr_accessor :name, :description, :scrape_url, :gyms, :zip_code


    # def self.new_from_listings(group_fitness)
    #     self.new(group_fitness.name, group_fitness.description)
    # end

    def initialize(name=nil,description=nil)
        @name = name
        @description = description
        @@all << self
    end

    # def to_s
    #     @name
    # end

    def self.all
        @@all
    end

    # def find_by_name(name)
    #     all.select {|fitness_klass| fitness_klass.name == name}[0]
    # end



end