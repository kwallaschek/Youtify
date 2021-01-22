class AddBackgroundjobInfoToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :background_job_running, :boolean
  end
end
