class AccountsUsersController < ApplicationController
  
   # the user must be authenticated
  before_action :authenticate_user!
  
  # Create an association between the current user and the account
  def create
    #begin
      
    @user = current_user
    @account = Account.find(params[:account][:id])
    @user.accounts << @account
    redirect_to account_path(:region => @account.region, :idLoL => @account.idLoL)
    #rescue
     # flash.now[:alert] = "Une erreur inconnue est survenue, veuillez contacter l'administrateur du site."
      #render "error/custom_error"
      
    #end
  end
  
  # Remove the association between the current user and the account
  def destroy
    
    @user = current_user
    @account = Account.find(params[:account][:id])
    @account.users.delete(@user)
    redirect_to(:back)
    
  end
  
end
