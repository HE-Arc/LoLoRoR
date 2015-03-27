class AccountsTrackgroupsController < ApplicationController
  
  # the user must be authenticated
  before_action :authenticate_user!
  
  # Create an association between the trackgroup and an existing account
  def create
    
    @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    @account = Account.find(params[:account][:id])
    @trackgroup.accounts << @account
    redirect_to account_path(:region => @account.region, :idLoL => @account.idLoL)
    
  end
  
  # Create an association between the trackgroup and the account using the API for find the account
  def createAPI
    
    idLoL = LOL_WRAPPER.get_summoner_id(params[:accname],  params[:region])
    #Find the summoner with the corresponding id and region
    @summoner = LOL_WRAPPER.get_summoner_by_id(idLoL, params[:region])
    
    #Create or update the corresponding account in our database
    if Account.exists?(:idLoL => idLoL)
      @account = Account.find_by_idLoL(idLoL)
      @account.pseudoLoL = @summoner.name
      @account.save
    else
      @account = Account.new(idLoL: idLoL, region: params[:region], pseudoLoL: @summoner.name)
      @account.save
    end
    
    @trackgroup = Trackgroup.find(params[:id])

    @trackgroup.accounts << @account
    redirect_to(:back)
    
  end
  
   # Remove the association between the trackgroup and the account
  def destroy
    
    @trackgroup = Trackgroup.find(params[:account][:idTrackgroup])
    @account = Account.find(params[:account][:idAccount])
    @account.trackgroups.delete(@trackgroup)
    redirect_to(:back)
    
  end
end
