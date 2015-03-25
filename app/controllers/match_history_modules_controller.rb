class MatchHistoryModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create]
  
  def new
    @accountJson = current_user.accounts.to_json
    @trackgroupJson = current_user.trackgroups.accounts.to_json
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  def get_params
    params[:dashboard].permit(:name)
  end
  
  private
  def check_user
    @matchHistory = MatchHistoryModule.find(params[:id])
    
     #the current user must own the resource
    if @matchHistory.dashboard.user != current_user
      render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
