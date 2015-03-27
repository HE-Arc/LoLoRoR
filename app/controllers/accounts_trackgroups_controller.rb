class AccountsTrackgroupsController < ApplicationController
  
  # the user must be authenticated
  before_action :authenticate_user!
  
  # Create an association between the trackgroup and the account
  def create
    
    @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    @account = Account.find(params[:account][:id])
    @trackgroup.accounts << @account
    redirect_to account_path(:region => @account.region, :idLoL => @account.idLoL)
    
  end
  
   # Remove the association between the trackgroup and the account
  def destroy
    
    @trackgroup = Trackgroup.find(params[:account][:idTrackgroup])
    @account = Account.find(params[:account][:idAccount])
    @account.trackgroups.delete(@trackgroup)
    redirect_to(:back)
    
  end
end
