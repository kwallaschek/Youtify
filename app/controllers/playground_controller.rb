class PlaygroundController < ApplicationController
  def new
    Yt.configure do |config|
      config.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
    end
    @video = Yt::Video.new id: "gknzFj_0vvY"
  end
end
