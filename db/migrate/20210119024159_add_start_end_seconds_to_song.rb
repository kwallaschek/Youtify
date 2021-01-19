class AddStartEndSecondsToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :startSeconds, :integer
    add_column :songs, :endSeconds, :integer
    add_column :songs, :songDuration, :integer
    remove_column :songs, :start_timecode, :string
    remove_column :songs, :stop_timecode, :string
  end
end
