class PlaylistImporterJob < ApplicationJob
  queue_as :default
  before_enqueue :print_before_enqueue_message
  def perform(pl_id, playlist)
    Yt.configuration.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
    p "Importing Playlist #{pl_id}... "

    pl = Yt::Playlist.new id: pl_id
    pl.playlist_items.each do |item|
      video = Yt::Video.new id: item.video_id
      song = Song.new
      song.name = item.title
      song.yid = video.id
      song.songDuration = video.duration
      song.startSeconds = 0
      song.endSeconds = video.duration
      song.playlist = playlist
      song.save
      if playlist.songs.size == playlist.ytPlSize
        break
      end
    end
    playlist.background_job_running = false
    playlist.save
    p "Done importing Playlist #{pl.id}"
  end

  def print_before_enqueue_message
    p "message"
  end
end
