class MatchHistoryModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create]
  
  def new
    @matchHistoryModule = MatchHistoryModule.new
    render "views/modules/history/_new"
  end
  
  def create
    @matchHistoryModule = matchHistoryModule.new(get_params)
    if(@matchHistoryModule.save)
      render "views/modules/history/_match"
    else
      render status: 400
      render plain: "Error"
    end
  end
  
  def edit
    render "views/modules/history/_edit"
  end
  
  def update
    if(@matchHistoryModule.update(get_params))
      render "views/modules/history/_match"
    else
      render status: 400
      render plain: "Error"
    end
  end
  
  def destroy
    
  end
  
  private
  def get_params
    params[:matchHistoryModule].permit(:account, :dashboard, :nb_match)
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
