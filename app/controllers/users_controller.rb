class UsersController < ApplicationController
  
  # The user must be authenticated for see his profil
  before_action :authenticate_user!
  
  # GET /users/[:id]
  def show
    @user = User.find(params[:id])
  end
  
  # GET /users
  def showCurrentUser
    @user = current_user
    render "show"
  end

end
