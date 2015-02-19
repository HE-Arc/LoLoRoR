class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(get_params)
    #TODO validation
    if(@user.save)
      #TODO ask Riot for LoL username
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    #TODO validation
    if(@user.update(get_params))
      #TODO ask Riot for LoL username
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  private
  def get_params
    params[:user].permit(:idLoL, :password)
  end
  
end
