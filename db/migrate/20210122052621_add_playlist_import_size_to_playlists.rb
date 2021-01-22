class AddPlaylistImportSizeToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :ytPlSize, :int
  end
end
