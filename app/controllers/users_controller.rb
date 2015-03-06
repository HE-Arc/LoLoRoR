class UsersController < ApplicationController
  
  # GET /users/[:id]
  def show
    @user = User.find(params[:id])
    @accounts = @user.accounts #.paginate(:page => params[:page], :per_page => 2)
    @account = @user.accounts.build
  end
  
end
