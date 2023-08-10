class AddOnHoldDateTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :on_hold_at, :datetime
    add_column :books, :on_hold_expires_at, :datetime
  end
end
