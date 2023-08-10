class BookOnHold < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :on_hold, :boolean, default: false
  end
end
