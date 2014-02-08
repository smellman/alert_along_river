class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin?
    unless session[:admin_user]
      redirect_to :controller => :admin_account, :action => :index
      return false
    end
    @admin_user = AdminUser.find_by_id(session[:admin_user][:id])
    unless @admin_user
      redirect_to :controller => :admin_account, :action => :index
      return false
    end
  end

end
