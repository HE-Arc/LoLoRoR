class AccountsController < ApplicationController

  # the user must be authenticated
  before_action :authenticate_user!, :except => [:show, :searchAccounts]


  LOL_WRAPPER = LolWrapper.new
  def show

    @idLoL = params[:idLoL]
    @region = params[:region]
    searchAccounts

  end

  def showUserAccounts
    @user = current_user
    @accounts = @user.accounts
  end

  def searchAccounts
    begin
      if !defined?(@idLoL) 
        tmp = LOL_WRAPPER.get_summoner_id(params[:name],  params[:region])
        @idLoL = tmp
        @region = params[:region]
      end

      if !@idLoL.nil? 
        puts(@idLoL)
        find_summoner
        render "show"
        #render :nothing => true
      end
    rescue Lol::NotFound
      @error = {:title => "Utilisateur non existant", :message => "L'utilisateur que vous avez demandé n'existe pas !"}
      flash.now[:alert] = @error[:message]
      render "error/custom_error"
    rescue 
      @error = {:title => "Utilisateur non existant", :message => "L'OLOLOLOL !"+@idLoL.to_s}
      flash.now[:alert] = @error[:message]
      render "error/custom_error"
      
    end
    #rescue Lol::InvalidAPIResponse 
    #render ""
    #render :text =>

    #end
  end

  def find_summoner
    #Find the summoner with the corresponding id and region
    begin
      @summoner = LOL_WRAPPER.get_summoner_by_id(@idLoL,@region)

      #Find the stats of the summoner with the corresponding id and region
      @file_stats = LOL_WRAPPER.get_file_stats(@idLoL,@region)

      #Find if is playing
      @isPlaying = LOL_WRAPPER.get_is_playing(@idLoL, @region)


      @file_ranks =  LOL_WRAPPER.get_file_ranks(@idLoL, @region)
      #TODO check error

      @file_history =  LOL_WRAPPER.get_file_history(@idLoL, @region)


      #Create or update the corresponding account in our database
      if Account.exists?(:idLoL => @idLoL)
        @account = Account.find_by_idLoL(@idLoL)
        @account.pseudoLoL = @summoner.name
        @account.save
      else
        @account = Account.new(idLoL: @idLoL, region: @region, pseudoLoL: @summoner.name)
        @account.save

      end

      if user_signed_in?
        @user = current_user
        @trackgroups = @user.trackgroups
      end
    rescue
      @error = {:title => "SHUT UP BOLHINAS", :message => "L'SHUT UP BOLHINAS !"}
      flash.now[:alert] = @error[:message]
      render "error/custom_error"
    end

  end
end
