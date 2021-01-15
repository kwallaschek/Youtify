class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit update destroy]
  def create
    @song = Song.new(song_params)
    @song.start_timecode = '0:00'
    @song.stop_timecode = '0:00'
    begin
      extractedYid = @song.yid[/([a-z]|[A-Z]|[0-9]|_){11}/]
      begin
        video = Yt::Video.new id: extractedYid
        @song.name = video.title
        @song.yid = extractedYid
      rescue
        flash[:alarm] = "Couldn't find a video with this ID"

      end
    rescue
      flash[:alarm] = "No ID found"
    end

    if @song.save
      flash[:notice] = t('addSong success')
      redirect_to playlist_path(song_params[:playlist_id])
    else
      flash[:alarm] = "Couldn't find video ID"
      redirect_to playlist_path(song_params[:playlist_id])
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
    params.require(:song).permit( :name, :yid, :start_timecode, :stop_timecode, :playlist_id)
  end
  def set_song
    @song = Song.find(params[:id])
  end
end
