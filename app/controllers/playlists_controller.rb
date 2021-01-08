class PlaylistsController < ApplicationController
  before_action :set_pl, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]


  def index
    @songs = @playlist.songs
  end

  def show; end

  def edit; end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update(playlist_params)
      flash[:notice] = t('pl update success')
      redirect_to controller: 'welcome', action: 'index', id: @playlist.id
    else
      flash[:alert] = "failed"
      redirect_to controller: 'welcome', action: 'index', id: @playlist.id
    end
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      flash[:notice] = t('create Pl success')
      redirect_to controller: 'welcome', action: 'index', id: @playlist.id
    else
      flash[:alert] = "failed"
      redirect_to controller: 'welcome', action: 'index', id: @playlist.id
    end
  end

  def destroy
    @playlist.destroy
    flash[:notice] = t('pl deleted')
    redirect_to root_path
  end

  private

  def set_pl
    @playlist = Playlist.find(params[:id])
  end

  def require_same_user
    redirect_to root_path if current_user != @playlist.user
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
