class TrackgroupsController < ApplicationController
  
  # The user must be authenticated for manage trackgroup
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create, :showUserTrackgroups]
  
  def show
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
  end
  
  def update
    if(@trackgroup.update(get_params))
      redirect_to @trackgroup
    else
      render 'edit'
    end
  end
  
 def destroy 
    @trackgroup = Trackgroup.find(params[:id])
    @trackgroup.destroy
   redirect_to users_trackgroups_path
  end
  
  private
  def get_params
    params[:trackgroup].permit(:name)
  end
  
  private
  def check_user
    @trackgroup = Trackgroup.find(params[:id])
     #the current user must own the resource
    if @trackgroup.user != current_user
      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
