class AccountsController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!, :except => [:show]
  
  def show
    #Find the summoner with the corresponding id and region
    @summoner = LOL_WRAPPER.get_summoner_by_id(params[:idLoL],params[:region])
    
    #Find the stats of the summoner with the corresponding id and region
    @stats = LOL_WRAPPER.get_account_infos(params[:idLoL],params[:region])
    
    #Find if is playing
    @isPlaying = LOL_WRAPPER.get_is_playing(params[:idLoL], params[:region])
    
    #Find ranking
    @ranking = LOL_WRAPPER.get_account_ranked_league(params[:idLoL], params[:region])
    @tier, @solo_rank = LOL_WRAPPER.get_solo_ranking(@ranking, params[:idLoL])
    @tier = @tier.downcase
    @tier_image = @solo_rank.sub(' ', '_').upcase + ".png"
    #TODO check error
    
    #Create or update the corresponding account in our database
    if Account.exists?(:idLoL => params[:idLoL])
      @account = Account.find_by_idLoL(params[:idLoL])
      @account.pseudoLoL = @summoner.name
      @account.save
    else
      @account = Account.new(idLoL: params[:idLoL], region: params[:region], pseudoLoL: @summoner.name)
      @account.save
    end
    if user_signed_in?
      @user = current_user
      @trackgroups = @user.trackgroups
    end
  end
  
  
  
  
  def showUserAccounts
    @user = current_user
    @accounts = @user.accounts
  end
  
  def searchAccounts
    #TODO utiliser l'API
    @accounts = Account.all
    render "showUserAccounts"
  end
  
end
