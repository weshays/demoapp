class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :researcher, null: false, default: false
      t.timestamps
    end

    add_index :users, :name
    add_index :users, :researcher
  end
end
