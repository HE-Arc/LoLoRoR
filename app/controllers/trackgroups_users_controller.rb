class TrackgroupsUsersController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!
  
  # Create an association between the trackgroup and the account
  def create
     
    @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    @account = Account.find(params[:account][:id])
    @trackgroup.accounts << @account
    redirect_to @account
    
  end
  
   # Remove the association between the trackgroup and the account
  def destroy
    
    @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    @account = Account.find(params[:account][:id])
    @account.users.delete(@trackgroup)
    redirect_to @account
    
  end
  
end