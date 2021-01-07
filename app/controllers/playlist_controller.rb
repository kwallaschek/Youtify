class PlaylistController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]


  def index
    @songs = @playlist.songs
  end

  def show; end

  def edit; end

  def update; end

  def create; end

  def destroy
    @playlist.destroy
    flash[:notice] = t('pl deleted')
    redirect_to root_path
  end

  private

  def set_article
    @playlist = Playlist.find(params[:id])
  end

  def require_same_user
    redirect_to root_path if current_user != @playlist.user
  end
end
