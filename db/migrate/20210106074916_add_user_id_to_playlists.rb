class AddUserIdToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :user_id, :int
  end
end
