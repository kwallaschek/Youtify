class AddRepeatModeToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :repeat, :boolean
  end
end
