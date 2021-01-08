class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:show,:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = t('user update success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t('welcome sign up')
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = t('acc delete success')
    redirect_to '/tbd'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    begin
      @user = User.find(params[:id])
      @playlists = @user.playlists
      @playlist = Playlist.new
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end
  def require_same_user
    if current_user != @user
      #flash[:alert] = "You can only edit your own account"
      redirect_to root_path
    end
  end
end