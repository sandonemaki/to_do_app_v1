class AddImageStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :image_status, :string
  end
end
