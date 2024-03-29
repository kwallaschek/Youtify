class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit update destroy]
  def create
    @song = Song.new(song_params)

    begin
      extractedYid = @song.yid[/([a-z]|[A-Z]|[0-9]|_|-){11}/]
      begin
        video = Yt::Video.new id: extractedYid
        @song.name = video.title
        @song.yid = extractedYid
        @song.songDuration = video.duration
        @song.startSeconds = 0
        @song.endSeconds = video.duration
      rescue
        flash[:alarm] = t('errorIdNotFound')
      end

    rescue
      flash[:alarm] = t('errorNoIdFound')
    end

    if @song.save
      flash[:notice] = t('addSong success')
      redirect_to playlist_path(song_params[:playlist_id])
    else
      flash[:alarm] = t('errorNoIdFound')
      redirect_to playlist_path(song_params[:playlist_id])
    end
  end

  def update
    if @song.update(song_params)
      flash[:notice] = t('song update success')
      redirect_to playlist_path(@song.playlist_id)
    else
      render 'edit'
    end
  end

  def destroy
    plid = @song.playlist_id
    @song.destroy
    flash[:notice] = t('song deleted')
    redirect_to playlist_path(plid)
  end

  private
  def song_params
    params.require(:song).permit( :name, :yid, :startSeconds, :endSeconds, :playlist_id, :position)
  end
  def set_song
    @song = Song.find(params[:id])
  end
end
