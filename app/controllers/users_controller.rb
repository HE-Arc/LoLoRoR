class UsersController < ApplicationController
  
  # The user must be authenticated for see his profil
  before_action :authenticate_user!
  before_action :check_admin, except: [:showCurrentUser]
  
  # GET /users/all
  def index
    @users = User.all
  end
  
  # GET /users/[:id]
  def show
    @user = User.find(params[:id])
  end
  
  # GET /users
  def showCurrentUser
    @user = current_user
    render "show"
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   redirect_to users_all_path
  end
  
  private
  def check_admin
    if !current_user.admin?
       render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
