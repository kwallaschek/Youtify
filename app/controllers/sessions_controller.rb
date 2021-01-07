class SessionsController < ApplicationController

  def new
    redirect_to '/loggedin' if logged_in?
  end
  def index
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = t('logged in success')
      redirect_to root_path
    else
      flash.now[:alert] = t('logged in error')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('logged out')
    redirect_to root_path
  end

end
