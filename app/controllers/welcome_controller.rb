class WelcomeController < ApplicationController
  before_action :set_first_playlists
  def index

  end

  def set_current_playlist
    if !params[:id].nil?
      @current_playlist = Playlist.find(params[:id])
    else
      redirect_to root_path
    end
    @playlists = current_user.playlists
    render 'index'
    rescue AbstractController::DoubleRenderError
      puts "caught"
  end
  def set_first_playlists
    if logged_in?
      if params[:id].nil?
        @current_playlist  ||= current_user.playlists.first
      else
        @current_playlist = Playlist.find(params[:id])
      end
      @playlists  ||= current_user.playlists
      @playlist = Playlist.new(:user_id => @current_user)
      @song = Song.new
    end
  end
end
