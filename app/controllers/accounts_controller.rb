class AccountsController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!, :except => [:show]
  
  def show
    
    @idLoL = params[:idLoL]
    @region = params[:region]
    
    find_account_and_save
    
  end
  
  def showUserAccounts
    @user = current_user
    @accounts = @user.accounts
  end
  
  def searchAccounts
    
    @idLoL = LOL_WRAPPER.get_summoner_id(params[:name],  params[:region])
    @region = params[:region]
    
    find_account_and_save
    
    render "show"
  end
  
  private
  def find_account_and_save
   #Find the summoner with the corresponding id and region
    @summoner = LOL_WRAPPER.get_summoner_by_id(@idLoL,@region)
    
    #Find the stats of the summoner with the corresponding id and region
    @stats = LOL_WRAPPER.get_account_infos(@idLoL,@region)
    
    #Find if is playing
    @isPlaying = LOL_WRAPPER.get_is_playing(params[:idLoL], params[:region])
    
    #Find ranking
    @ranking = LOL_WRAPPER.get_account_ranked_league(params[:idLoL], params[:region])
    @tier, @solo_rank = LOL_WRAPPER.get_solo_ranking(@ranking, params[:idLoL])
    @tier = @tier.downcase
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
  end
  
end
