class UserBooksAssignment < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :checked_out_by, type: :uuid, index: true, foreign_key: { to_table: :users }
    add_reference :books, :on_hold_by, type: :uuid, index: true, foreign_key: { to_table: :users }
  end
end
