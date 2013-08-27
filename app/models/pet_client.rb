require 'json'
require 'open-uri'
require 'digest/md5'
require 'pry'
require 'nokogiri'
require 'date'


class PetClient

  @@token_hash = Hash.new
  def initialize
  end

  def self.get_token
    key_secret="#{ENV['PET_SECRET']}key=#{ENV['PET_KEY']}"
    md5 = Digest::MD5.hexdigest(key_secret)
    @@token_hash = Hash.new
    @@token_hash[:md5] = md5
    @@token_hash[:time] = Time.now
    expires = Date.new
    url = "http://api.petfinder.com/auth.getToken?key=#{ENV['PET_KEY']}&sig=#{@@token_hash[:md5]}"
    updated_url = URI.encode(url)
    result = Nokogiri::XML(open(updated_url.strip).read)
    @@token_hash[:token] = result.xpath("//auth//token/text()").text.strip
    parsed_date = Time.at(result.xpath("//auth/expires/text()").text.strip.to_i)
    @@token_hash[:expires] = parsed_date.strftime('%a %d %b %Y %I:%M:%S %p')
  end


  def self.breed_list(animal)
   search_string = "#{ENV['PET_SECRET']}key=#{ENV['PET_KEY']}&animal=#{animal}&format=json&token=#{@@token_hash[:token]}"
   sig = Digest::MD5.hexdigest(search_string)
   url = "http://api.petfinder.com/breed.list?key=#{ENV['PET_KEY']}&animal=#{animal}&format=json&token=#{@@token_hash[:token]}&sig=#{sig}"
   updated_url = URI.encode(url)
   result = JSON.parse(open(updated_url.strip).read)
  end

  def self.load_breeds(pet)
    pet[:breeds] = breed_list(pet[:name])['petfinder']['breeds']['breed'].map { |b|
        b["$t"]
    }

  end

  def self.search_listings(pet, options={})
    name = (pet[:name].nil?) ? false : pet[:name]
    breeds = options[:breeds].nil? ? false : options[:breeds]
    size = options[:size].nil? ? false : options[:size]
    sex = options[:sex].nil? ? false : options[:sex]
    location = options[:location].nil? ? false : options[:location]
    age = options[:age].nil? ? false : options[:age]
    offset = options[:offse].nil? ? false : options[:offset]
    count = options[:count].nil? ? false : options[:count]

    # this is a custom option not supported by API
    distance = options[:distance].nil? ? false : options[:distance]


  end

end
