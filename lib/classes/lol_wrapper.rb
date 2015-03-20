require 'rubygems'
require 'singleton'
require 'lol'
#also requires a redis server running on localhost:6379
#this is achievable using "parts install redis" followed by "parts start redis" once

#this class is meant to be a singleton, TODO: singletonize the stuff
class LolWrapper
  include Singleton
  attr_accessor :list_clients, :api_key
  def initialize
    @list_clients = Hash.new
    @api_key = CONFIG[:api_key]
  end
  
  #gets a client using a server name. if it doesn't exist, it creates a new client and adds it to the hash
  def get_check_client(name)
    region_name = name.downcase
    if region_name.is_a? String
      unless @list_clients.has_key?region_name
        @list_clients[region_name] = Lol::Client.new @api_key, {region: region_name, redis: "redis://localhost:6379", ttl: 900}
      end
      return @list_clients[region_name]
    else
      raise 'Client name is not a string.'
    end
  end
  
  #gets the summoner's level, using their name and server's region name
  def get_level(summoner_name, region_name)
    client = get_check_client(region_name)
    summoner = client.summoner.by_name(summoner_name)[0]
    return summoner.summoner_level
  end
end