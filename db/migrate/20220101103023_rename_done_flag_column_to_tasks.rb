class RenameDoneFlagColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :dane_flag, :done_flag
  end
end
