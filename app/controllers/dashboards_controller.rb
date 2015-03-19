class DashboardsController < ApplicationController
  
  # The user must be authenticated for manage trackgroup
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create, :showUserDashboards]
  
  def show
  end
  
  def showUserDashboards
    @user = current_user
    @dashboards = @user.dashboards
    
  end

  def new
    @dashboard = Dashboard.new
  end
  
  def create
    @dashboard = Dashboard.new(get_params)
    @dashboard.user = current_user
    if(@dashboard.save)
      redirect_to @dashboard
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if(@dashboard.update(get_params))
      redirect_to @dashboard
    else
      render 'edit'
    end
  end
  
 def destroy 
    @dashboard.destroy
    redirect_to dashboards_path
  end
  
  private
  def get_params
    params[:dashboard].permit(:name)
  end
  
  private
  def check_user
    @dashboard = Dashboard.find(params[:id])
     #the current user must own the resource
    if @dashboard.user != current_user
      render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
