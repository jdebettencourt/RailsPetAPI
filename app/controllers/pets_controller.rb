class PetsController < ApplicationController

  def home

    #method to get breeds
      # p = Pet.new
      # PetClient.get_token
      # PetClient.load_breeds(p.cat)
      # puts p.cat[:breeds]
    p = PetSearch.new
    #@results = PetClient.search_listings(p.dog)
    PetClient.get_token
    @results = PetClient.load_breeds(p.dog)
  end

end
