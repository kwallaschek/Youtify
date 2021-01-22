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
      redirect_to playlist_path(@playlist)
    else
      flash[:alert] = "failed"
      redirect_to controller: 'welcome', action: 'index', id: @playlist.id
    end
  end

  def updateImportNumber
    p "called Update Import Number"
    @playlist = Playlist.find(params[:playlist_id])
    respond_to do |format|

      format.js { render "updateImportNumber", layout: false}
      format.js { render "playlist", layout: false}
      format.json {render json: {stillImporting: @playlist.background_job_running}}
    end

  end

  def create
    @playlist = Playlist.new(name: playlist_params[:name], background_job_running: false)
    @playlist.user = current_user
    if !playlist_params[:y_pl_id].nil?
      begin
        list = playlist_params[:y_pl_id][/[&?]list=([^&]+)/i]
        begin
          extracted_list_id = list[list.index('=') + 1..-1]
          pl = Yt::Playlist.new id: extracted_list_id
        rescue
          flash[:alert] = "Couldn't find a PlaylistID"
          redirect_to controller: 'welcome', action: 'index'
        end
        @playlist.background_job_running = true
        @playlist.ytPlSize = pl.playlist_items.size
        @playlist.save
        PlaylistImporterJob.perform_later(extracted_list_id, @playlist)
        flash[:notice] = t('create Pl success') + ' importing now...'
        redirect_to playlist_path(@playlist.id)
      rescue
        flash[:alert] = "failed"
        redirect_to controller: 'welcome', action: 'index'
      end

    else
      if @playlist.save
        flash[:notice] = t('create Pl success')
        redirect_to playlist_path(@playlist.id)
      else
        flash[:alert] = "failed"
        redirect_to controller: 'welcome', action: 'index'
      end
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
    @playlists = current_user.playlists.all
    Yt.configuration.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
    @song = Song.new
  end

  def require_same_user
    redirect_to root_path if current_user != @playlist.user
  end

  def playlist_params
    params.require(:playlist).permit(:name, :y_pl_id)
  end
end
