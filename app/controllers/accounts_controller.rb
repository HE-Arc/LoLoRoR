class AccountsController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!, :except => [:show]
  
  def show
    @account = Account.find(params[:id])
    # if the user is signed in, we find all his trackgroups so he can add a account to one of his trackgroup
    if user_signed_in?
      @user = current_user
      @trackgroups = @user.trackgroups
      @level = LOL_WRAPPER.get_level(@account.pseudoLoL, @account.region)
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
  
  private
  def get_params
    params[:account].permit(:pseudoLoL,:region)
  end
  
end
