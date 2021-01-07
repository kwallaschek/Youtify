class WelcomeController < ApplicationController
  before_action :set_first_playlists, only: [:index]
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
      @current_playlist  ||= current_user.playlists.first
      @playlists  ||= current_user.playlists
    end
  end
end
