class PlaygroundController < ApplicationController
  before_action :set_playlists

  def index
    Yt.configure do |config|
      config.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
    end

  end

  private
  def set_playlists
    @playlists = current_user.playlists
    @playlist = Playlist.new
  end
end
