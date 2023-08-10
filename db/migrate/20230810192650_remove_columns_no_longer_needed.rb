class RemoveColumnsNoLongerNeeded < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :checked_out
    remove_column :books, :on_hold
  end
end
