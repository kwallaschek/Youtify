class AddShuffleModeToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :shuffle, :boolean
  end
end
