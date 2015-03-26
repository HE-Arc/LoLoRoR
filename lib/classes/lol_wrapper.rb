require 'rubygems'
require 'singleton'
require 'lol'
require 'net/http'

#also requires a redis server running on localhost:6379
#this is achievable using "parts install redis" followed by "parts start redis" once

#this class is meant to be a singleton, TODO: singletonize the stuff
class LolWrapper
  include Singleton
  attr_accessor :list_clients, :api_key, :ddragon_region, :ddragon_version, :region_list
  
  def initialize
    @list_clients = Hash.new
    @api_key = CONFIG[:api_key]
    set_ddragon_infos('euw')
    populate_region_list()
  end
  
  def get_all_regions
    return @region_list
  end
  
  #gets the summoner profile using summoner_id and region_name
  def get_summoner_by_id(summoner_id, region_name)
    client = get_check_client(region_name)
    return client.summoner.get(summoner_id)[0]
  end
  
  #returns a loading-screen picture of the champion refered by champion_id the skin can be selected with skin_id
  def get_champion_image_link(champion_id, skin_id = '0')
    champion = get_champion(champion_id)
    return "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/"+champion.name+"_"+skin_id+".jpg"
  end
  
  #returns a little square picture of the champion refered by champion_id
  def get_champion_square_link(champion_id)
    champion = get_champion(champion_id)
    return "http://ddragon.leagueoflegends.com/cdn/"+@ddragon_version+"/img/champion/"+champion.name+".png"
  end
  
  #gets the current game of the player refered by account_id on region_name server
  def get_current_game(account_id, region_name)
    client = get_check_client(region_name)
    current_game = nil
    begin
      current_game = client.current_game.spectator_game_info(  "1", account_id )
    rescue
      puts "Summoner not in game"
    end
    return current_game
  end
  
  def get_is_playing(accout_id, region_name)
    return !get_current_game(accout_id,region_name).nil?
  end
  
  #gets the summoner id of the player refered by summoner_name on region_name server
  def get_summoner_id(summoner_name, region_name)
    client = get_check_client(region_name)
    return client.summoner.by_name(summoner_name)[0].id
  end
  #gets a stats summary of the player refered by account_id on region_name server
  def get_account_infos(account_id, region_name)
    client = get_check_client(region_name)
    return client.stats.summary(account_id)
  end
  
  #gets the ranked infos of the player refered by account_id on region_name server
  def get_account_ranked_infos(account_id, region_name)
    client = get_check_client(region_name)
    return client.stats.ranked(account_id)
  end

  def get_solo_ranking(ranking, account_id)
    rank_infos = ranking[account_id]
    rank_div = rank_value = "Unranked"
    rank_infos.each do |item|
      if item.queue == "RANKED_SOLO_5x5"
        rank_value = item.tier.capitalize
        item.entries.each do |entry|
          if entry.player_or_team_id == account_id
            rank_div = rank_value + " " + entry.division
            break
          end
        end
        
      end
    end
    return rank_value, rank_div
  end
  
  def get_account_ranked_league(account_id, region_name)
    client = get_check_client(region_name)
    return client.league.get(account_id)
  end
  
  #gets the match history of the player refered by account_id on region_name server
  def get_match_history(account_id, region_name)
    client = get_check_client(region_name)
    return client.game.recent(account_id)
  end
  
  private
  #gets a client using a server name. if it doesn't exist, it creates a new client and adds it to the hash
  def get_check_client(name)
    region_name = name.downcase
    if region_name.is_a? String
      #TODO could check if region name is in region_list
      unless @list_clients.has_key?region_name
        @list_clients[region_name] = Lol::Client.new @api_key, {region: region_name, redis: "redis://localhost:6379", ttl: 900}
      end
      return @list_clients[region_name]
    else
      raise 'Client name is not a string.'
    end
  end
  
  def get_static_client
    client = get_check_client(@ddragon_region) #this is dirty, but hey, it works
                                     #(should create a static client, but since there is no such thing included in the gem...)
    return client.static
  end
  
  
  
  #gets champion data
  def get_champion(champion_id)
    return get_static_client.champion.get(champion_id, champData: 'all')
  end
  
  #gets all item data
  def get_item(item_id)
    return get_static_client.item.get(item_id, itemData: 'all')
  end
  
  #gets all summoner spell data
  def get_summoner_spell(ss_id)
    get_static_client.summoner_spell.get(ss_id, spellData: 'all')
  end
  
  #gets all mastery data
  def get_mastery(mastery_id)
    get_static_client.mastery.get(mastery_id, masteryData: 'all')
  end
  
  #gets all rune data
  def get_rune(rune_id)
    get_static_client.rune.get(rune_id, runeData: 'all')
  end
  
  #called at server start, creates and populates the array of regions
  def populate_region_list
    @region_list = Array.new
    #not an api-official way, but all the regions are listed in this not-api-key-limited query
    requestString = 'http://status.leagueoflegends.com/shards'
    uri = URI(requestString)
    response = Net::HTTP.get(uri)
    responseJSON = JSON.parse(response)
    #iterates over the response and adds the region tag at the end of the list
    responseJSON.each do |child|
      @region_list.push(child['slug'])
    end
  end
  
  #using the region_name server, gets the ddragon version and sets the @ddragon_version variable
  def set_ddragon_infos(region_name)
    @ddragon_region = region_name
    requestString = 'https://global.api.pvp.net/api/lol/static-data/euw/v1.2/versions?api_key='+ @api_key
    uri = URI(requestString)
    response = Net::HTTP.get(uri)
    responseJSON = JSON.parse(response)
    @ddragon_version = responseJSON[0]
  end
end