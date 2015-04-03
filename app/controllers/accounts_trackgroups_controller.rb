class AccountsTrackgroupsController < ApplicationController
  
  # the user must be authenticated
  before_action :authenticate_user!
  before_action :check_user
  
  # Create an association between the trackgroup and an existing account
  def create
    
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

    @trackgroup.accounts << @account
    redirect_to(:back)
    
  end
  
   # Remove the association between the trackgroup and the account
  def destroy
    
    @account = Account.find(params[:account][:idAccount])
    @account.trackgroups.delete(@trackgroup)
    redirect_to(:back)
    
  end
  
  private
  def check_user
    if params.has_key?(:id)
      @trackgroup = Trackgroup.find(params[:id])
    else
      @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    end
     #the current user must own the resource
    if @trackgroup.user != current_user
      render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
