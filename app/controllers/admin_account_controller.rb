class AdminAccountController < ApplicationController

  def index
  end

  def login
    if params[:name].blank?
      flash[:error] = "Please input user name"
      render action: "index"
      return
    end
    if params[:password].blank?
      flash[:error] = "Please input password"
      render action: "index"
      return
    end
    admin_user = AdminUser.where(:name => params[:name]).first.try(:authenticate, params[:password])
    unless admin_user
      flash[:error] = "Invalid user name or password"
      render action: "index"
      return
    end
    session[:admin_user] = admin_user
    redirect_to :controller => :areas, :action => :index
  end

  def logout
    session[:admin_user] = nil
    reset_session
    redirect_to action: "index"
  end
end
