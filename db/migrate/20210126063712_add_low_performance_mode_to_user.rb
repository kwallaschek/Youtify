class AddLowPerformanceModeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :low_performance, :boolean
  end
end
