class UsersController < ApplicationController
  
  # GET /resource/[:id]
  def show
    @user = User.find(params[:id])
  end
  
end
