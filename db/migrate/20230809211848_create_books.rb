class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title, null: false
      t.boolean :checked_out, null: false, default: false
      t.boolean :restricted, null: false, default: false
      t.timestamps
    end
  end
end
