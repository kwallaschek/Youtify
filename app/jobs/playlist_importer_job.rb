class PlaylistImporterJob < ApplicationJob
  queue_as :default
  def perform(pl_id, playlist)
    Yt.configuration.api_key = "AIzaSyCJk_Y4ViQjwJhhFfW-Wyd9t2dLYqWeT-U"
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
  end
end
