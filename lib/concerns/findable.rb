# module Concerns
#     module Findable

#         def find_or_create(name, description=nil, fitness_class_id, location_name, address, distance)
#             find = all.detect {|thing| thing if thing.name == name} 
#             find == nil? self.new(name, description=nil, fitness_class_id, location_name, address, distance)
#         end
#     end
        
# end