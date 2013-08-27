class Pet < ActiveRecord::Base
  attr_accessible :animal

 def initialize(animal)
  @animal = animal
 end



end


