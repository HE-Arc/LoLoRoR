class MatchHistoryModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create]
  
  def show
    render "modules/history/_match"
  end
  
  def new
    @matchHistoryModule = MatchHistoryModule.new
    @dashboard = Dashboard.find(params[:dashID])
    @accounts = current_user.accounts
    @trackgroups = current_user.trackgroups
    render "modules/history/_new"
  end
  
  def create
    @matchHistoryModule = MatchHistoryModule.new
    @matchHistoryModule.nb_match =  params[:nb_match]
    @matchHistoryModule.dashboard = Dashboard.find(params[:dashID])
    @matchHistoryModule.account = Account.find(params[:account_id])

    if(@matchHistoryModule.save)
      render "modules/history/_match"
    else
      render status: 400
      render plain: "Error"
    end
  end
  
  def edit
    @accounts = current_user.accounts
    @trackgroups = current_user.trackgroups
    render "modules/history/_edit"
  end
  
  def update
    @matchHistoryModule.nb_match =  params[:nb_match]
    @matchHistoryModule.account = Account.where(pseudoLoL:  params[:pseudoLoL], region: params[:region])
    if(@matchHistoryModule.save)
      render "modules/history/_match"
    else
      render status: 400
      render plain: "Error"
    end
  end
  
  def destroy
    @matchHistoryModule.destroy
    redirect_to dashboard_path(params[:dashID])
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
