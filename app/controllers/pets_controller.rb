class PetsController < ApplicationController

  require 'Pet'
  respond_to :json

  before_filter :get_token

  def listbreeds
     #http://localhost:3000/listbreeds/cat
     begin
       animal = params[:animal]
       p = PetSearch.new
       @results = PetClient.load_breeds(p.instance_variable_get("@#{animal}"))
       respond_with @results
     rescue NoMethodError
      respond_with "Error in request.  You probably typed something in wrong"
     end

  end

  def getpet
    #http://localhost:3000/getpet/1234567
    begin
      id = params[:id]
      @pet = PetClient.get_pet(id)
      respond_with @pet
    rescue NoMethodError
      respond_with "Error in request.  You probably typed something in wrong"
    end
  end


  def findpets
    #http://localhost:3000/findpets/animal=dog&94123&breeds=vizla,pug&Young.json
    begin
      options = params[:options]
      @results = Pet.make_search(options)
      respond_with @results
    rescue NoMethodError
      respond_with "Error in request.  You probably typed something in wrong"
    end
  end

  private
    def get_token
      PetClient.get_token()
    end

end
