class AddPlaylistIdToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :playlist_id, :int
  end
end
