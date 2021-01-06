class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :yid
      t.string :start_timecode
      t.string :stop_timecode

      t.timestamps
    end
  end
end
