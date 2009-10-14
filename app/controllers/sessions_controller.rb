# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  layout "shopping"
 # ssl_required :new, :create
  
  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      
      if params[:remember_me] == "1"
        self.current_admin_user.remember_me
        cookies[:auth_token] = { :value => self.current_admin_user.remember_token , :expires => self.current_admin_user.remember_token_expires_at }
      end
      flash[:notice] = "Logged in successfully"
      if self.current_user.role == 'admin'
        redirect_to admin_orders_path
      else
        redirect_back_or_default('/')
      end
    elsif (params[:login] == APP_CONFIG['wholesale_login'] && params[:password] == APP_CONFIG['wholesale_password'])
        session[:wholesaler] = "wholesaler" 
        redirect_to('/')
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_admin_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
