class AccountsController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!, :except => [:show, :searchAccounts]
  LOL_WRAPPER = LolWrapper.new
  def show
   
    @idLoL = params[:idLoL]
    @region = params[:region]
    
    find_summoner
    
  end
  
  def showUserAccounts
    @user = current_user
    @accounts = @user.accounts
  end
  
  def searchAccounts
    
   tmp = LOL_WRAPPER.get_summoner_id(params[:name],  params[:region])
   @idLoL = tmp
   @region = params[:region]
    
   
   find_summoner
    
   render "show"
  end
  
  def find_summoner
     #Find the summoner with the corresponding id and region
    @summoner = LOL_WRAPPER.get_summoner_by_id(@idLoL,@region)
    
    #Find the stats of the summoner with the corresponding id and region
    @stats = LOL_WRAPPER.get_account_infos(@idLoL,@region)
    
    @file_stats = LOL_WRAPPER.get_file_stats(@stats)
    
    #Find if is playing
    @isPlaying = LOL_WRAPPER.get_is_playing(@idLoL, @region)
    
    #Find ranking
    ranking = LOL_WRAPPER.get_account_ranked_league(@idLoL, @region)
    @tier, @solo_rank = LOL_WRAPPER.get_solo_ranking(ranking, @idLoL)
    @tier = @tier.downcase
    @tier_image = @solo_rank.sub(' ', '_').upcase + ".png"
    
    #TODO check error
    
    #Create or update the corresponding account in our database
    if Account.exists?(:idLoL => @idLoL)
      @account = Account.find_by_idLoL(@idLoL)
      @account.pseudoLoL = @summoner.name
      @account.save
    else
      @account = Account.new(idLoL: @idLoL, region: @region, pseudoLoL: @summoner.name)
      @account.save
    end
    
    if user_signed_in?
      @user = current_user
      @trackgroups = @user.trackgroups
    end
  end
end
