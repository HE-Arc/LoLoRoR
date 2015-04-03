class DashboardsController < ApplicationController
  
  # The user must be authenticated for manage trackgroup
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create, :showUserDashboards]
  
  # Texts used for the controls
  
  
  def show
    #@accounts = current_user.accounts
    #@trackgroups = current_user.trackgroups
    puts "LOL ICI"
    @historyModules = []
    @modules = @dashboard.match_history_modules
    @modules.each do |hm|
      @historyModules << {module: hm, history: LOL_WRAPPER.get_file_history(hm.account.idLoL, hm.account.region)}
    end
  end
  
  def showUserDashboards
    @user = current_user
    @dashboards = @user.dashboards    
  end

  def new
    @button_text = "Créer le dashboard"
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
    @button_text = "Mettre à jour"
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
   redirect_to users_dashboards_path
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
