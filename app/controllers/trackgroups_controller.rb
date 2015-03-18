class TrackgroupsController < ApplicationController
  
  # The user must be authenticated for manage trackgroup
  before_action :authenticate_user!
  
  def show
    @trackgroup = Trackgroup.find(params[:id])
    @accounts = @trackgroup.accounts
  end
  
  def showUserTrackgroups
    @user = current_user
    @trackgroups = @user.trackgroups
    
  end

  def new
    @trackgroup = Trackgroup.new
  end
  
  def create
    @trackgroup = Trackgroup.new(get_params)
    @trackgroup.user = current_user
    if(@trackgroup.save)
      redirect_to @trackgroup
    else
      render 'new'
    end
  end
  
  def edit
    @trackgroup = Trackgroup.find(params[:id])
  end
  
  def update
    @trackgroup = Trackgroup.find(params[:id])
    if(@trackgroup.update(get_params))
      redirect_to @trackgroup
    else
      render 'edit'
    end
  end
  
 def destroy 
    @trackgroup = Trackgroup.find(params[:id])
    @trackgroup.destroy
    redirect_to trackgroups_path
  end
  
  private
  def get_params
    params[:trackgroup].permit(:name)
  end
  
end
