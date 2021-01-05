class PlaygroundController < ApplicationController
  def new
    Yt.configure do |config|
      config.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
    end
    @video = Yt::Video.new id: "jrsAqmh_mak"
  end
end
