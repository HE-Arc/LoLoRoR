class InformationController < ApplicationController
  
  # Only the admin can manage informations
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_admin, except: [:index, :show]
  
  def index
    @informations = Information.all
    @page_number = 0
  end
  
  def show
    @information = Information.find(params[:id])
  end

  def new
    @information = Information.new
    @button_text = "Ajouter la news"
  end
  
  def create
    @information = Information.new(get_params)
    if(@information.save)
      redirect_to @information
    else
      render 'new'
    end
  end
  
  def edit
    @button_text = "Modifier la news"
    @information = Information.find(params[:id])
  end
  
  def update
    @information = Information.find(params[:id])
    if(@information.update(get_params))
      redirect_to @information
    else
      render 'edit'
    end
  end
  
 def destroy
   @information = Information.find(params[:id])
   @information.destroy
   redirect_to information_index_path
  end
  
  private
  def get_params
    params[:information].permit(:title, :smallDescription, :detailedDescription)
  end
  
  private
  def check_admin
    if !current_user.admin?
       render :file => "public/401.html", :status => :unauthorized
    end
  end
  
end
