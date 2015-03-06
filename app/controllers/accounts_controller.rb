class AccountsController < ApplicationController
  
  def show
    @account = Account.find(params[:id])
    # if the user is signed in, we find all his trackgroups so he can add a account to one of his trackgroup
    if user_signed_in?
      @user = current_user
      @trackgroups = @user.trackgroups
    end
  end

  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(get_params)
    #TODO Ask LoL API for the actual account information
    if(@account.save)
      redirect_to @account
    else
      render 'new'
    end
  end
  
  #Update the account with the informations received from the LoL API
  def update
    #TODO Ask LoL API for the actual account information
  end
  
  # the user must be authenticated for add account to his profil or to one of his trackgroups
  before_action :authenticate_user!, :only => [:addUser, :addTrackgroup]
  
  # Add the account to a user
  def addUser
     
    @user = current_user
    @account = Account.find(params[:id])
    @user.accounts << @account
    redirect_to @account
    
  end
  
  # Add the account to a trackgroup 
  def addTrackgroup
     
    @trackgroup = Trackgroup.find(params[:account][:trackgroups])
    @account = Account.find(params[:id])
    @trackgroup.accounts << @account
    redirect_to @account
    
  end
  
  private
  def get_params
    params[:account].permit(:pseudoLoL,:region)
  end
  
end
