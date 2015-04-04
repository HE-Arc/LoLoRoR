class AccountsUsersController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!
  
  # Create an association between the current user and the account
  def create
    
    @user = current_user
    puts "0"
    @account = Account.find(params[:account][:id])
    @user.accounts << @account
    puts "1"
    redirect_to account_path(:region => @account.region, :idLoL => @account.idLoL)
    puts "2"
    
  end
  
  # Remove the association between the current user and the account
  def destroy
    
    @user = current_user
    @account = Account.find(params[:account][:id])
    @account.users.delete(@user)
    redirect_to(:back)
    
  end
  
end
