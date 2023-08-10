class BookCheckedOutAtAndDueAt < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :checked_out_at, :datetime
    add_column :books, :due_at, :datetime
  end
end
