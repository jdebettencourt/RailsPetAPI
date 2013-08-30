require 'date'
require 'json'
require 'nokogiri'

class Pet
  attr_accessor :name, :age, :sex, :size, :petfinder_id, :shelter_id, :shelter_pet_id, :images, :breeds, :status, :contact, :description, :last_update, :options
  cattr_accessor :pets
  @@pets = Array.new
  def initialize
    @name = ''
    @age = ''
    @sex = ''
    @size = ''
    @petfinder_id = ''
    @shelter_id = ''
    @images = []
    @breeds = []
    @contact = {}
    @status = ''
    @description = ''
    @last_update = ''
    @options = []
    @shelter_pet_id = {}
  end

  def self.pets
    @@pets
  end

  def self.make_search(options)
    animal = options.match(/animal=(.*?)&/).nil? ? "ERROR" : options.match(/animal=(.*?)&/)[1]
    br=options.match(/&breeds=(.*?)&/).nil? ? [] : options.match(/&breeds=(.*?)&/)[1]
    breeds = br.split(',')
    offset = options.match(/&off(.*?)&/).nil? ? "" : options.match(/&off(.*?)&/)[1]
    count = options.match(/&ct(.*?)&/).nil? ? "" : options.match(/&ct(.*?)&/)[1]
    sex = options.match(/&sex=(.*?)&/).nil? ? "" : options.match(/&sex=(.*?)&/)[1]
    location = options.match(/((?:\d\d+)+)/).nil? ? "" : options.match(/((?:\d\d+)+)/)
    PetSearch.init_options("#{animal}", "#{location}", "ct#{count}", "#{sex}", "off#{offset}")
    PetSearch.options[:breeds] = breeds
    result = PetSearch.search
    make_pet(result)
  end

  def self.make_pet(result)
    @@pets = []
    result[0]['petfinder']['pets']['pet'].each do |pet|
        p = Pet.new
        if pet['options']['option'].class == Hash
          p.options << pet['options']['option']['$t']
        else p.options = pet['options']['option'].map { |t|
              t['$t'] }
        end
        if pet['breeds']['breed'].class == Hash
          p.options << pet['breeds']['breed']['$t']
        else
         p.breeds = pet['breeds']['breed'].map { |t|
          t['$t']}
        end
        p.shelter_pet_id = pet['shelterPetId'] ? pet['shelterPetId']['$t'] : ""
        p.status = pet['status']['$t']
        p.name = pet['name']['$t']
        p.contact[:email] = pet['contact']['email']['$t']
        p.contact[:zip] = pet['contact']['zip']['$t']
        p.contact[:city] = pet['contact']['city']['$t']
        p.contact[:fax] = pet['contact']['fax']['$t']
        p.contact[:address1] = pet['contact']['address1']['$t']
        p.contact[:phone] = pet['contact']['phone']['$t']
        p.contact[:state] = pet['contact']['state']['$t']
        p.description=HTMLEntities.new.decode(ActionView::Base.full_sanitizer.sanitize(pet['description']['$t']))
        p.sex = pet['sex']['$t']
        p.shelter_id = pet['shelterId']['$t']
        p.size = pet['size']['$t']
        p.age = pet['age']['$t']
        p.last_update = Date.parse((pet['lastUpdate']['$t'].split('T'))[0])
        p.images = pet['media']['photos']['photo'].map { |photo|
             photo['$t']
        }
        p.petfinder_id = pet['id']['$t']
       @@pets << p

     end
    return @@pets
  end

end


