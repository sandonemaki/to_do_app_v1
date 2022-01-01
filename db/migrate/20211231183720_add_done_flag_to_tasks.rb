class AddDoneFlagToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :done_flag, :integer
  end
end
