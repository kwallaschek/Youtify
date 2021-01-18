class AddOrderToSongsInPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :position, :int
  end
end
