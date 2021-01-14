class WelcomeController < ApplicationController
  def index
    respond_to do |format|
      format.html {redirect_to playlist_path(current_user.playlists.first), remote: true}
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

end
