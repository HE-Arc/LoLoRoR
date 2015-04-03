  class MatchHistoryModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, except: [:new, :create]

  def show
    @file_history =  LOL_WRAPPER.get_file_history(@mod.account.idLoL, @mod.account.region)
    render :partial => "modules/history/show"
  end

  def new
    @mod = MatchHistoryModule.new
    @dashboard = Dashboard.find(params[:dashID])
    @accounts = current_user.accounts
    @trackgroups = current_user.trackgroups
    return render :partial => "modules/history/new"
  end

  def create
    @mod  = MatchHistoryModule.new
    @moduleInfos = params[:module_infos]
    @mod.nb_match =  @moduleInfos[:nb_match]
    @mod.dashboard = Dashboard.find(@moduleInfos[:dash_id])
    @mod.account = Account.find(@moduleInfos[:account_id])
    @history = LOL_WRAPPER.get_file_history(@mod.account.idLoL, @mod.account.region)

    if(@mod.save)
      return render :partial => "modules/history/show"
    else
      render status: 400
      flash.now[:alert] = "Erreur : Ajout impossible"
    end
  end

  def edit
    @dashboard = Dashboard.find(params[:dashID])
    @accounts = current_user.accounts
    @trackgroups = current_user.trackgroups
    return render :partial => "modules/history/edit"
  end

  def update
    @moduleInfos = params[:module_infos]
    @mod.nb_match = @moduleInfos[:nb_match]
    @mod.account = Account.find(@moduleInfos[:account_id])
    @history = LOL_WRAPPER.get_file_history(@mod.account.idLoL, @mod.account.region)

    if(@mod.save)
      return render :partial => "modules/history/show"
    else
      flash.now[:alert] = "Erreur : Edition impossible"
      render status: 400
    end
  end

  def destroy
    @mod.destroy
    flash.now[:notice] = "Erreur : Edition impossible"
    render :nothing => true
  end

  private
  def check_user
    @mod = MatchHistoryModule.find(params[:id])
     #the current user must own the resource
    if @mod.dashboard.user != current_user
      render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
